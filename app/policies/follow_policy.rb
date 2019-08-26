# frozen_string_literal: true

class FollowPolicy < ApplicationPolicy
  def create?
    user? && !follower?
  end

  def destroy?
    user? && follower?
  end

  private

  def follower?
    user.follows.any? { |follow| follow.community_id == community.id }
  end
end
