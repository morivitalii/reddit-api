class Api::Communities::Posts::ExplicitPolicy < ApplicationPolicy
  def create?
    user? && (admin? || moderator?)
  end

  def destroy?
    user? && (admin? || moderator?)
  end
end
