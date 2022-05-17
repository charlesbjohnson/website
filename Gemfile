# frozen_string_literal: true

ruby "~> 3.1"
source "https://rubygems.org"

gem "actionview", "~> 7.0", require: "action_view"
gem "activesupport", "~> 7.0", require: "active_support/all"

gem "kramdown", "~> 2.4"
gem "kramdown-parser-gfm", "~> 1.1"
gem "nokogiri", "~> 1.13"
gem "rouge", "~> 3.28"

gem "ssg", path: "ssg"

group :development do
  gem "debug", "~> 1.5", require: false
  gem "rubocop", "~> 1.29", require: false
  gem "rubocop-minitest", "~> 0.19", require: false
  gem "standard", "~> 1.12", require: false
end

group :development, :test do
  gem "minitest", "~> 5.15", require: false
end
