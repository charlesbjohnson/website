# frozen_string_literal: true

module Components
  class Code < Component
    class << self
      def styles
        templates["code.css.erb"].render
      end
    end

    def initialize(caption: nil, lang: nil, name: nil, tag: "code")
      super()

      self.caption = caption
      self.lang = lang || (name ? File.extname(name)[1..] : nil)
      self.name = name
      self.tag = tag
    end

    def highlight(content)
      lexer ? formatter.format(lexer.lex(content)) : content
    end

    private

    def formatter
      @formatter ||= Rouge::Formatters::HTML.new
    end

    def lexer
      @lexer ||= Rouge::Lexer.find(lang)&.new
    end

    attr_accessor :caption, :lang, :name, :tag
  end
end
