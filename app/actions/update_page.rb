# frozen_string_literal: true

class UpdatePage
  include ActiveModel::Model

  attr_accessor :page, :current_user, :title, :text

  def save
    ActiveRecord::Base.transaction do
      @page.update!(
        title: @title,
        text: @text,
        edited_by: @current_user
      )

      CreateLog.new(
        sub: @page.sub,
        current_user: @current_user,
        action: :update_page,
        attributes: [:title, :text],
        model: @page
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
