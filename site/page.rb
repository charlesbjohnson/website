# frozen_string_literal: true

class Page < SSG::Page
  class << self
    delegate :title, :uri, to: :new
  end

  def title
    self.class.name.demodulize.titleize
  end

  def render?
    self.class != Page
  end
end
