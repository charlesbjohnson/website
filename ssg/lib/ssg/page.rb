# frozen_string_literal: true

module SSG
  class Page < Component
    # @return [String]
    def date
      created_at.to_date
    end

    # @return [Time]
    def created_at
      return @created_at if defined?(@created_at)

      abs_path = source.abs_path
      @created_at = begin
        ::File.birthtime(abs_path)
      rescue NotImplementedError
        Time.parse(`stat --printf %w #{abs_path}`)
      rescue ArgumentError
        updated_at
      end

      @created_at
    end

    # @return [String]
    def extension
      template.type
    end

    # @return [String]
    def slug
      self.class.name.underscore.dasherize
    end

    # @return [Time]
    def updated_at
      @updated_at ||= ::File.ctime(source.abs_path)
    end

    # @return [URI::Generic]
    def uri
      return @uri if defined?(@uri)

      @uri = URI.parse(self.class.name.casecmp("index").zero? ? "" : "/#{slug}")
      @uri.path += extension == "html" ? "/" : ".#{extension}"

      @uri
    end

    # @return [Boolean]
    def render?
      true
    end
  end
end
