class Api::Communities::Posts::Reports::IgnorePolicy < ApplicationPolicy
  def create?
    moderator? && !banned?
  end

  def destroy?
    moderator? && !banned?
  end
end
