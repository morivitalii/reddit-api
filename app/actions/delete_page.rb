# frozen_string_literal: true

class DeletePage
  def initialize(page:, current_user:)
    @page = page
    @current_user = current_user
  end

  def call
    @page.destroy!
  end
end
