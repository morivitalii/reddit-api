# frozen_string_literal: true

class DeletePost
  include ActiveModel::Model

  attr_accessor :post, :current_user, :deletion_reason

  def save
    @post.delete!(@current_user, @deletion_reason)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
