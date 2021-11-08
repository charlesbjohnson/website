# frozen_string_literal: true

class Page < SSG::Page
  def render?
    self.class != Page
  end
end
