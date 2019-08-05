# frozen_string_literal: true

class DeleteFollowService
  attr_reader :sub, :user

  def initialize(sub, user)
    @sub = sub
    @user = user
  end

  def call
    Follow.where(sub: sub, user: user).destroy_all
  end
end
