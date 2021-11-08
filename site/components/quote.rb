# frozen_string_literal: true

module Components
  class Quote < Component
    class << self
      def styles
        templates["quote.css.erb"].render
      end
    end

    def initialize(origin: nil, href: nil)
      super()

      self.origin = origin
      self.href = href
    end

    private

    attr_accessor :origin, :href
  end
end
