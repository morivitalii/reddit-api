# frozen_string_literal: true

class DeletePageService
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def call
    page.destroy!
  end
end
