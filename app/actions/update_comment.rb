# frozen_string_literal: true

class UpdateComment
  include ActiveModel::Model

  attr_accessor :comment, :text

  def save
    @comment.update!(text: @text)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
