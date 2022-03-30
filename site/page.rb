# frozen_string_literal: true

class Page < SSG::Page
  class << self
    delegate :date, :title, :uri, to: :new

    def fingerprint
      define_method(:uri) do
        URI.parse("/#{slug}-#{fingerprint}.#{extension}")
      end
    end
  end

  def fingerprint
    Digest::SHA256.hexdigest(render)[..20]
  end

  def title
    self.class.name.demodulize.titleize
  end

  def render?
    self.class.name != Page.name
  end
end
