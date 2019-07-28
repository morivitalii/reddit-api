# frozen_string_literal: true

class ApproveComment
  def initialize(comment, current_user)
    @comment = comment
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      @comment.approve!(current_user)

      CreateLog.new(
          sub: @comment.sub,
          current_user: @current_user,
          action: :mark_thing_as_approved,
          attributes: [:approved_at, :deleted_at, :deletion_reason, :text],
          loggable: @comment,
          comment: @comment
      ).call
    end
  end
end
