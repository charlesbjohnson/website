# frozen_string_literal: true

module SSG
  class Config
    class << self
      attr_writer :env, :dir_in, :dir_out, :serve_host, :serve_port

      # @return [String]
      def env
        @env ||= ENV.fetch("SSG_ENV", "development")
      end

      # @return [Pathname]
      def dir_in
        @dir_in ||= dir.join("site")
      end

      # @return [Pathname]
      def dir_out
        @dir_out ||= dir.join("_site")
      end

      # @return [Pathname]
      def abs_path
        dir.join("config.rb")
      end

      # @return [String]
      def serve_host
        @serve_host ||= ENV.fetch("SSG_HOST", "localhost")
      end

      # @return [Integer]
      def serve_port
        @serve_port ||= Integer(ENV.fetch("SSG_PORT", 4000))
      end

      # @return [URI::HTTP]
      def serve_uri
        URI::HTTP.build(host: serve_host, port: serve_port)
      end

      private

      def dir
        Pathname.pwd
      end
    end
  end
end
