# frozen_string_literal: true

ruby "~> 3.1"
source "https://rubygems.org"

gem "actionview", "~> 7.0", require: "action_view"
gem "activesupport", "~> 7.0", require: "active_support/all"

gem "kramdown", "~> 2.3"
gem "kramdown-parser-gfm", "~> 1.1"

gem "rouge", "~> 3.28"

gem "ssg", path: "ssg"

group :development do
  gem "debug", "~> 1.5", require: false
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-minitest", "~> 0.18", require: false
  gem "standard", "~> 1.9", require: false
end

group :development, :test do
  gem "minitest", "~> 5.15", require: false
end
