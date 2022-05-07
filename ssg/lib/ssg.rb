# frozen_string_literal: true

require "rubygems"

require "date"
require "fileutils"
require "pathname"
require "singleton"
require "strscan"

require "active_support"
require "active_support/all"
require "listen"
require "webrick"
require "zeitwerk"

module SSG
  require "ssg/template"
  require "ssg/template/engine"

  require "ssg/component"
  require "ssg/component/source"

  require "ssg/page"
  require "ssg/page/output"

  require "ssg/file"
  require "ssg/file/static_file"
  require "ssg/file/template_file"
  require "ssg/file/output"

  require "ssg/config"
  require "ssg/server"
  require "ssg/site"

  require "ssg/cli"
end
