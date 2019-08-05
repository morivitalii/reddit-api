# frozen_string_literal: true

class ApproveCommentService
  attr_reader :comment, :user

  def initialize(comment, user)
    @comment = comment
    @user = user
  end

  def call
    comment.approve!(user)
  end
end
