# frozen_string_literal: true

ruby "3.1.0"
source "https://rubygems.org"

gem "actionview", "~> 7.0", require: "action_view"
gem "activesupport", "~> 7.0", require: "active_support/all"

gem "kramdown", "~> 2.3"
gem "kramdown-parser-gfm", "~> 1.1"

gem "rouge", "~> 3.27"

gem "ssg", path: "ssg"

group :development do
  gem "debug", "~> 1.4", require: false
  gem "rubocop", "~> 1.25", require: false
  gem "rubocop-minitest", "~> 0.17", require: false
  gem "standard", "~> 1.7", require: false
end

group :development, :test do
  gem "minitest", "~> 5.15", require: false
end
