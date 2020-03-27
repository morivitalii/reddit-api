class Api::Communities::Posts::SpoilerPolicy < ApplicationPolicy
  def create?
    user? && (admin? || moderator?)
  end

  def destroy?
    user? && (admin? || moderator?)
  end
end
