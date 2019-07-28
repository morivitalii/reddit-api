# frozen_string_literal: true

class DeleteComment
  include ActiveModel::Model

  attr_accessor :comment, :current_user, :deletion_reason

  def save
    @comment.delete!(@current_user, @deletion_reason)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
