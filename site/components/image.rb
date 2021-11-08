# frozen_string_literal: true

module Components
  class Image < Component
    class << self
      def styles
        templates["image.css.erb"].render
      end
    end

    def initialize(src:, alt:, caption: alt)
      super()

      self.src = src
      self.alt = alt

      self.caption = caption
    end

    private

    attr_accessor :src, :alt, :caption
  end
end
