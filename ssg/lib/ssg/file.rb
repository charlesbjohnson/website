# frozen_string_literal: true

module SSG
  class File
    class << self
      # @param [String, #to_s] pattern
      # @return [Array<SSG::File::StaticFile, SSG::File::TemplateFile>]
      def glob(pattern)
        Dir.glob(pattern.to_s).filter_map { |path| locate(Pathname.new(path)) }
      end

      # @param [Pathname] path
      # @return [SSG::File::StaticFile, SSG::File::TemplateFile, nil]
      def locate(path)
        StaticFile.locate(path) || TemplateFile.locate(path)
      end
    end

    # @return [Pathname]
    attr_reader :abs_path

    # @return [String]
    delegate :to_s, to: :content

    # @param [Pathname] abs_path
    def initialize(abs_path)
      self.abs_path = abs_path
    end

    # @return [Pathname]
    def rel_path
      abs_path.relative_path_from(Site.config.dir_in)
    end

    # @return [String]
    def content
      ::File.read(abs_path)
    end

    # @return [URI::Generic]
    def uri
      @uri ||= URI.parse("/#{rel_path.dirname.to_s.dasherize}/#{rel_path.basename}")
    end

    # @return [Boolean]
    def static?
      false
    end

    # @return [Boolean]
    def template?
      false
    end

    private

    attr_writer :abs_path
  end
end
