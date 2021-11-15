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

    def scripts
      block_given? ? self.scripts = yield : @scripts
    end

    def styles
      block_given? ? self.styles = yield : @styles
    end

    private

    attr_accessor :favicon, :description
    attr_writer :main, :scripts, :styles
  end
end
