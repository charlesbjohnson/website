# frozen_string_literal: true

module Layouts
  class BlogPost < Layout
    def initialize(page:, **opts)
      super(page: page)

      self.opts = opts
    end

    private

    attr_accessor :opts
  end
end
