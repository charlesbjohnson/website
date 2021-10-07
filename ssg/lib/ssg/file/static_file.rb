# frozen_string_literal: true

module SSG
  class File
    class StaticFile < File
      class << self
        # @param [Pathname] path
        # @return [SSG::File::StaticFile, nil]
        def locate(path)
          path.file? && [".rb", ".erb"].exclude?(path.extname) ? new(path) : nil
        end
      end

      # @return [Boolean]
      def static?
        true
      end
    end
  end
end
