# frozen_string_literal: true

module SSG
  class File
    class TemplateFile < File
      class << self
        # @param [Pathname] path
        # @return [SSG::File::TemplateFile, nil]
        def locate(path)
          path.file? && path.extname == ".erb" ? new(path) : nil
        end
      end

      # @return [Boolean]
      def template?
        true
      end
    end
  end
end
