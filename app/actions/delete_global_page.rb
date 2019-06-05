# frozen_string_literal: true

class DeleteGlobalPage
  def initialize(page:, current_user:)
    @page = page
    @current_user = current_user
  end

  def call
    @page.destroy!

    CreateLogJob.perform_later(
      current_user: @current_user,
      action: "delete_global_page",
      model: @page
    )
  end
end
