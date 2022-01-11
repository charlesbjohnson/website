# frozen_string_literal: true

module Stylesheets
  class Style < Page
    fingerprint

    def template
      templates["style.css.erb"]
    end
  end
end
