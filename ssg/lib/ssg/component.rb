# frozen_string_literal: true

module SSG
  class Component
    class << self
      # @return [Hash<String, SSG::File::StaticFile>]
      def files
        source.static_files
      end

      # @return [Hash<String, SSG::Template>]
      def templates
        source.template_files.transform_values { |file| Template.new(file) }
      end

      private

      def source
        Source.new(self)
      end
    end

    # @return [Hash<String, SSG::File::StaticFile>]
    def files
      @files ||= self.class.files
    end

    # @return SSG::Template
    def template
      @template ||= templates["#{self.class.name.demodulize.underscore}.html.erb"]
    end

    # @return [Hash<String, SSG::Template>]
    def templates
      @templates ||= self.class.templates
    end

    # @yield
    # @return [String]
    def render(&block)
      template.render(self, &block)
    end
  end
end
