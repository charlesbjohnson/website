# frozen_string_literal: true

class Blog < Page
  def posts(&block)
    Site.pages.select { |page| page.is_a?(Post) }.sort_by(&:date).reverse_each(&block)
  end

  module Post
    def preview
      raise NotImplementedError
    end
  end
end
