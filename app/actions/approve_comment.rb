# frozen_string_literal: true

class ApproveComment
  def initialize(comment, current_user)
    @comment = comment
    @current_user = current_user
  end

  def call
    @comment.approve!(current_user)
  end
end
