# frozen_string_literal: true

ruby "3.0.2"
source "https://rubygems.org"

gem "actionview", "~> 6.1", require: "action_view"
gem "activesupport", "~> 6.1", require: "active_support/all"

gem "kramdown", "~> 2.3"
gem "kramdown-parser-gfm", "~> 1.1"

gem "rouge", "~> 3.26"

gem "ssg", path: "ssg"

group :development do
  gem "debug", "~> 1.3", require: false
  gem "rubocop", "~> 1.22", require: false
  gem "rubocop-minitest", "~> 0.16", require: false
  gem "standard", "~> 1.4", require: false
end

group :development, :test do
  gem "minitest", "~> 5.14", require: false
end
