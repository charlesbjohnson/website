# frozen_string_literal: true

module SSG
  class File
    class Output
      extend Forwardable

      # @return [URI::Generic]
      delegate uri: :file

      # @param [SSG::File]
      def initialize(file)
        self.file = file
      end

      # @return [Pathname]
      def rel_path
        @path ||= Pathname.new(file.uri.to_s[1..])
      end

      private

      attr_accessor :file
    end
  end
end
