# frozen_string_literal: true

class ApprovePost
  def initialize(post, current_user)
    @post = post
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      @post.approve!(current_user)

      CreateLog.new(
        sub: @post.sub,
        current_user: @current_user,
        action: :mark_thing_as_approved,
        attributes: [:approved_at, :deleted_at, :deletion_reason, :text],
        loggable: @post,
        post: @post
      ).call
    end
  end
end
