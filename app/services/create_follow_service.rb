# frozen_string_literal: true

class CreateFollowService
  attr_reader :sub, :user

  def initialize(sub, user)
    @sub = sub
    @user = user
  end

  def call
    Follow.find_or_create_by!(sub: sub, user: user)
  end
end
