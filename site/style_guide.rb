# frozen_string_literal: true

class StyleGuide < Page
  def render?
    Site.development?
  end
end
