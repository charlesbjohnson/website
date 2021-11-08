# frozen_string_literal: true

module Components
  class Markdown < Component
    def render
      Kramdown::Document.new(yield.strip_heredoc.strip, input: "GFM", hard_wrap: false).to_html
    end
  end
end
