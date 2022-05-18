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

    def phone
      ENV.fetch("PHONE", "+1 (000) 000 000")
    end

    def github_url
      @github_url ||= URI::HTTPS.build(host: "github.com", path: "/charlesbjohnson")
    end

    def linkedin_url
      @linkedin_url ||= URI::HTTPS.build(host: "www.linkedin.com", path: "/in/charles-johnson-89250a111")
    end

    def uri
      production? ? URI::HTTPS.build(host: domain) : URI::HTTP.build(host: "localhost", port: SSG::Site.config.serve_port)
    end

    def development?
      !production?
    end

    def production?
      SSG::Site.config.env == "production"
    end
  end
end
