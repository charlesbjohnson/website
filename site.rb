# frozen_string_literal: true

class Site
  class << self
    def configure(&block)
      block.call(SSG::Site.config)
    end

    def pages
      SSG::Site.pages
    end

    def uri
      production? ? URI::HTTPS.build(host: "cbjohnson.info") : SSG::Site.config.serve_uri
    end

    def development?
      !production?
    end

    def production?
      SSG::Site.config.env == "production"
    end
  end
end
