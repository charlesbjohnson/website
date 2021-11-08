# frozen_string_literal: true

class Blog
  class NewManagerReadme < Page
    include Post

    def date
      Date.parse("2021-11-02")
    end

    def title
      "Personal README: Manager Edition"
    end

    def preview
      "The introductory email I send to my new manager at any job."
    end
  end
end
