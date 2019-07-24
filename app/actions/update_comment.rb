# frozen_string_literal: true

class UpdateComment
  include ActiveModel::Model

  attr_accessor :comment, :current_user, :text

  def save
    @comment.update!(
      text: @text,
      edited_by: @current_user,
      edited_at: Time.current
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
