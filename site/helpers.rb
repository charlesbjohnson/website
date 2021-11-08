# frozen_string_literal: true

module Helpers
  extend ActionView::Helpers::TagHelper

  class << self
    def content_tag(name, content_or_options_with_block = nil, options = nil, &block)
      super(name, content_or_options_with_block, options, false, &block)
    end

    def capture
      yield
    end
  end
end
