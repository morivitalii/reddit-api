# frozen_string_literal: true

class UpdatePage
  include ActiveModel::Model

  attr_accessor :page, :current_user, :title, :text

  def save
    @page.update!(
      title: @title,
      text: @text,
      edited_by: @current_user,
      edited_at: Time.current
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
