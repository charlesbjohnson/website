# frozen_string_literal: true

class Site
  class << self
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
