# frozen_string_literal: true

class FollowPolicy < ApplicationPolicy
  def create?
    user? && !follower?
  end

  def destroy?
    follower?
  end
end
