# frozen_string_literal: true

class CreateFollowService
  attr_reader :community, :user

  def initialize(community, user)
    @community = community
    @user = user
  end

  def call
    Follow.find_or_create_by!(community: community, user: user)
  end
end
