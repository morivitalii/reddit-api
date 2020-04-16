class Api::Communities::Posts::SpoilerPolicy < ApplicationPolicy
  def create?
    admin? || (!exiled? && moderator?)
  end

  def destroy?
    admin? || (!exiled? && moderator?)
  end
end
