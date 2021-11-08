# frozen_string_literal: true

module Components
  class Favicon < Component
    attr_accessor :emoji

    def initialize(emoji:)
      super()

      self.emoji = emoji
    end
  end
end
