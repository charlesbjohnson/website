# frozen_string_literal: true

ruby "~> 3.2"
source "https://rubygems.org"

gem "actionview", "~> 7", require: "action_view"
gem "activesupport", "~> 7", require: "active_support/all"

gem "kramdown", "~> 2"
gem "kramdown-parser-gfm", "~> 1"
gem "nokogiri", "~> 1"
gem "rouge", "~> 4"

gem "ssg", path: "ssg"

group :development do
  gem "debug", "~> 1", require: false
  gem "rubocop", "~> 1", require: false
  gem "rubocop-minitest", "~> 0", require: false
  gem "standard", "~> 1", require: false
end

group :development, :test do
  gem "minitest", "~> 5", require: false
end
