# frozen_string_literal: true

class Blog
  class NewTeammateReadme < Page
    include Post

    def date
      Date.parse("2021-11-03")
    end

    def title
      "Personal README: Teammate Edition"
    end

    def preview
      "The introductory email I send to my new teammates at any job."
    end
  end
end
