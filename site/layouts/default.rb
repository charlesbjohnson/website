# frozen_string_literal: true

module Layouts
  class Default < Layout
    def initialize(page:, **opts, &block)
      super(page: page)

      self.favicon = opts[:favicon]
      self.description = opts[:description]

      block&.call(self)
    end

    def main
      block_given? ? self.main = yield : @main
    end

    private

    attr_accessor :favicon, :description
    attr_writer :main
  end
end
