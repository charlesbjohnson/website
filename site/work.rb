# frozen_string_literal: true

class Work < Page
  def content(name, selector = nil)
    text = templates["#{name}.md.erb"].render(self)

    Components::Markdown.new.render do
      selector ? Nokogiri.HTML(text).at_css(selector).text : text
    end
  end
end
