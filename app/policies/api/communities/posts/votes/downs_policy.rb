class Api::Communities::Posts::Votes::DownsPolicy < ApplicationPolicy
  def create?
    user? && (admin? || (!exiled? && !muted? && !banned?))
  end

  def destroy?
    user? && (admin? || (!exiled? && !muted? && !banned?))
  end
end
