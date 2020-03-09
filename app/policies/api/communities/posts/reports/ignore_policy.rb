class Api::Communities::Posts::Reports::IgnorePolicy < ApplicationPolicy
  def create?
    moderator?
  end

  def destroy?
    moderator?
  end
end
