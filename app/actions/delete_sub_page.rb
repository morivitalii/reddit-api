# frozen_string_literal: true

class DeleteSubPage
  def initialize(page:, current_user:)
    @page = page
    @current_user = current_user
  end

  def call
    @page.destroy!

    CreateLogJob.perform_later(
      sub: @page.sub,
      current_user: @current_user,
      action: "delete_sub_page",
      model: @page
    )
  end
end
