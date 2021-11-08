# frozen_string_literal: true

module Stylesheets
  class Style < Page
    def template
      templates["style.css.erb"]
    end
  end
end
