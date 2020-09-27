class Api::Communities::FollowsPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end

  def show?
    !exiled? && !banned?
  end

  def create?
    user? && !exiled? && !banned? && !follower?
  end

  def destroy?
    user? && !exiled? && !banned? && follower?
  end

  private

  def follower?
    user.follows.any? { |follow| follow.followable_id == community.id }
  end
end
