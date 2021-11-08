# frozen_string_literal: true

class Blog
  class Hello < Page
    include Post

    def date
      Date.parse("2021-11-01")
    end

    def preview
      "A post about saying hello"
    end
  end
end
