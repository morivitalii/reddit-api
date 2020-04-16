class Api::Communities::Posts::Comments::Reports::IgnorePolicy < ApplicationPolicy
  def create?
    admin? || (!exiled? && moderator?)
  end

  def destroy?
    admin? || (!exiled? && moderator?)
  end
end
