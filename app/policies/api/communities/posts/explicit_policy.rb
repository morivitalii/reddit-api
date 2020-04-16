class Api::Communities::Posts::ExplicitPolicy < ApplicationPolicy
  def create?
    admin? || (!exiled? && moderator?)
  end

  def destroy?
    admin? || (!exiled? && moderator?)
  end
end
