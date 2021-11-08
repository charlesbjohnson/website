# frozen_string_literal: true

module Layouts
  class Default < Layout
    def initialize(page:, **opts)
      super(page: page)

      self.favicon = opts[:favicon]
      self.description = opts[:description]
    end

    private

    attr_accessor :favicon, :description
  end
end
