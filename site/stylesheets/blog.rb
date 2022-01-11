# frozen_string_literal: true

module Stylesheets
  class Blog < Page
    fingerprint

    def template
      templates["blog.css.erb"]
    end
  end
end
