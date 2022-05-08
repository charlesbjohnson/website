# frozen_string_literal: true

module SSG
  class Site
    include Singleton

    using(Module.new do
      refine Class do
        # @return [Array<Class>]
        def descendants
          rec = ->(klass) {
            (klass == self ? [] : [klass]) + klass.subclasses.flat_map { |child| rec.call(child) }
          }

          rec.call(self)
        end
      end
    end)

    class << self
      extend Forwardable

      # @return [SSG::Config]
      delegate config: :instance

      # @return [Hash<String, SSG::File::StaticFile>]
      delegate files: :instance

      # @return [Array<SSG::Page>]
      delegate pages: :instance

      delegate [:boot, :reboot] => :instance

      def build
        instance.clean
        boot
        instance.build
      end

      def serve
        instance.clean
        boot(reloading: true)
        instance.serve
      end

      private :instance
    end

    def initialize
      self.loader = Zeitwerk::Loader.new

      loader.ignore(config.abs_path)
      loader.push_dir(config.dir_in)
    end

    # @param [Boolean] reloading
    def boot(reloading: false)
      require_relative(config.abs_path) if config.abs_path.exist?

      loader.enable_reloading if reloading
      loader.setup
      loader.eager_load

      nil
    end

    def reboot
      loader.reload
      loader.eager_load

      nil
    end

    def build
      files.each_value do |file|
        output = File::Output.new(file)
        FileUtils.mkdir_p(config.dir_out.join(output.rel_path.dirname))
        FileUtils.cp(config.dir_in.join(file.rel_path), config.dir_out.join(output.rel_path))
      end

      pages.each do |page|
        output = Page::Output.new(page)
        FileUtils.mkdir_p(config.dir_out.join(output.rel_path.dirname))
        ::File.write(config.dir_out.join(output.rel_path), page.render)
      end

      nil
    end

    def clean
      FileUtils.rm_rf(config.dir_out)
    end

    # @return [SSG::Config]
    def config
      Config
    end

    def serve
      server = Server.new
      thread = Thread.new { server.start }
      Signal.trap("INT") { server.stop }
      thread.join
    rescue ThreadError
    end

    # @return [Hash<String, SSG::File::StaticFile>]
    def files
      File.glob(config.dir_in.join("**/*")).each_with_object({}) { |file, h|
        h[file.rel_path.to_s] = file if file.static?
      }
    end

    # @return [Array<SSG::Page>]
    def pages
      Page.descendants.sort_by(&:object_id).reverse.uniq(&:to_s).map(&:new).select(&:render?)
    end

    private

    attr_accessor :loader
  end
end
