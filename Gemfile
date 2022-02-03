# frozen_string_literal: true

ruby "3.1.0"
source "https://rubygems.org"

gem "actionview", "~> 6.1", require: "action_view"
gem "activesupport", "~> 6.1", require: "active_support/all"

gem "kramdown", "~> 2.3"
gem "kramdown-parser-gfm", "~> 1.1"

gem "rouge", "~> 3.26"

gem "ssg", path: "ssg"

group :development do
  gem "debug", "~> 1.3", require: false
  gem "rubocop", "~> 1.23", require: false
  gem "rubocop-minitest", "~> 0.17", require: false
  gem "standard", "~> 1.5", require: false
end

group :development, :test do
  gem "minitest", "~> 5.14", require: false
end
