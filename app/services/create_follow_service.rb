# frozen_string_literal: true

class CreateFollowService
  attr_reader :community, :user

  def initialize(community, user)
    @community = community
    @user = user
  end

  def call
    follow.present? ? follow : Follow.create!(community: community, user: user)
  end

  private

  def follow
    @_follow ||= Follow.where(community: community, user: user).take
  end
end
