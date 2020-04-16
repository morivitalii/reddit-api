class Api::Communities::Posts::Reports::IgnorePolicy < ApplicationPolicy
  def create?
    admin? || (!exiled? && moderator?)
  end

  def destroy?
    admin? || (!exiled? && moderator?)
  end
end
