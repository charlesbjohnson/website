# frozen_string_literal: true

module SSG
  class Page
    class Output
      # @param [SSG::Page] page
      def initialize(page)
        self.page = page
      end

      # @return [Pathname]
      def rel_path
        return @path if defined?(@path)

        @path = Pathname.new(page.uri.to_s[1..])
        @path = @path.join("index") if page.template.type == "html"
        @path = @path.sub_ext(".#{page.template.type}")

        @path
      end

      # @return [Array<URI::Generic>]
      def uris
        return @uris if defined?(@uris)

        @uris = [page.uri]
        @uris.push(URI.parse("#{page.uri}index.html")) if page.template.type == "html"

        @uris
      end

      private

      attr_accessor :page
    end
  end
end
