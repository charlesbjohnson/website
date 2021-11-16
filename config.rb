# frozen_string_literal: true

require "debug"
Bundler.require

require_relative "./site"

Site.configure do |c|
  c.serve_host = ENV.fetch("HOST", "0.0.0.0")
  c.serve_port = ENV.fetch("PORT", 8080).to_i
end
