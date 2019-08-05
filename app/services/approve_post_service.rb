# frozen_string_literal: true

class ApprovePostService
  attr_reader :post, :user

  def initialize(post, user)
    @post = post
    @user = user
  end

  def call
    post.approve!(user)
  end
end
