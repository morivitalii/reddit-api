# frozen_string_literal: true

class DeletePage
  def initialize(page:, current_user:)
    @page = page
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      @page.destroy!

      CreateLog.new(
        sub: @page.sub,
        current_user: @current_user,
        action: :delete_page,
        attributes: [:title, :text],
        model: @page
      ).call
    end
  end
end
