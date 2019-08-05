# frozen_string_literal: true

class DeletePostForm
  include ActiveModel::Model

  attr_accessor :post, :user, :reason

  def save
    post.remove!(user, reason)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
