# frozen_string_literal: true

class Blog
  class HelloWorld < Page
    include Post

    def date
      Date.parse("2021-11-01")
    end

    def preview
      "On the subject of (re)building my personal website."
    end
  end
end
