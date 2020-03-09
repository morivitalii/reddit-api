class Api::Communities::Posts::Comments::Reports::IgnorePolicy < ApplicationPolicy
  def create?
    moderator?
  end

  def destroy?
    moderator?
  end
end
