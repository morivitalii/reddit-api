# frozen_string_literal: true

class ApprovePost
  def initialize(post, current_user)
    @post = post
    @current_user = current_user
  end

  def call
    @post.approve!(@current_user)
  end
end
