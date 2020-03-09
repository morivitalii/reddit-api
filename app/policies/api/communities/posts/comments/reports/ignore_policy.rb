class Api::Communities::Posts::Comments::Reports::IgnorePolicy < ApplicationPolicy
  def create?
    moderator? && !banned?
  end

  def destroy?
    moderator? && !banned?
  end
end
