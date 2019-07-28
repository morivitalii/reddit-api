# frozen_string_literal: true

class DeleteComment
  include ActiveModel::Model

  attr_accessor :comment, :current_user, :deletion_reason

  def save
    ActiveRecord::Base.transaction do
      @comment.delete!(@current_user, @deletion_reason)

      CreateLog.new(
          sub: @comment.sub,
          current_user: @current_user,
          action: :mark_thing_as_deleted,
          attributes: [:deleted_at, :deletion_reason, :approved_at, :text],
          loggable: @comment,
          model: @comment
      ).call
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
