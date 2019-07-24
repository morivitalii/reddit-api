# frozen_string_literal: true

class UpdatePost
  include ActiveModel::Model

  attr_accessor :post, :current_user, :text

  def save
    @post.update!(
      text: @text,
      edited_by: @current_user,
      edited_at: Time.current
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
