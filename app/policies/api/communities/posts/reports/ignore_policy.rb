class Api::Communities::Posts::Reports::IgnorePolicy < ApplicationPolicy
  def create?
    user? && (admin? || moderator?)
  end

  def destroy?
    user? && (admin? || moderator?)
  end
end
