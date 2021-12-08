# frozen_string_literal: true

class Site
  class << self
    def configure(&block)
      block.call(SSG::Site.config)
    end

    def pages
      SSG::Site.pages
    end

    def domain
      @domain ||= File.read("site/CNAME").strip
    end

    def email
      "mail@#{domain}"
    end

    def github_url
      @github ||= URI::HTTPS.build(host: "github.com", path: "/charlesbjohnson")
    end

    def uri
      production? ? URI::HTTPS.build(host: domain) : SSG::Site.config.serve_uri
    end

    def development?
      !production?
    end

    def production?
      SSG::Site.config.env == "production"
    end
  end
end
