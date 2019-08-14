# frozen_string_literal: true

class DeleteFollowService
  attr_reader :community, :user

  def initialize(community, user)
    @community = community
    @user = user
  end

  def call
    Follow.where(community: community, user: user).destroy_all
  end
end
