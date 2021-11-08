# frozen_string_literal: true

class Layout < Component
  def initialize(page:)
    self.page = page
  end

  private

  attr_accessor :page
end
