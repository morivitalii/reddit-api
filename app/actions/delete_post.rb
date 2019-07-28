# frozen_string_literal: true

class DeletePost
  include ActiveModel::Model

  attr_accessor :post, :current_user, :deletion_reason

  def save
    ActiveRecord::Base.transaction do
      @post.delete!(@current_user, @deletion_reason)

      CreateLog.new(
        sub: @post.sub,
        current_user: @current_user,
        action: :mark_thing_as_deleted,
        attributes: [:deleted_at, :deletion_reason, :approved_at, :text],
        loggable: @post,
        model: @post
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
