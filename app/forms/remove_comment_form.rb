# frozen_string_literal: true

class RemoveCommentForm
  include ActiveModel::Model

  attr_accessor :comment, :user, :reason

  def save
    comment.remove!(user, reason)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end

  def persisted?
    true
  end
end
