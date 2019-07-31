# frozen_string_literal: true

class FollowPolicy < ApplicationPolicy
  def create?
    user_signed_in? && !user_sub_follower?
  end

  def destroy?
    user_signed_in? && user_sub_follower?
  end
end
