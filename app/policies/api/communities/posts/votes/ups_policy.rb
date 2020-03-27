class Api::Communities::Posts::Votes::UpsPolicy < ApplicationPolicy
  def create?
    user? && (admin? || (!muted? && !banned?))
  end

  def destroy?
    user? && (admin? || (!muted? && !banned?))
  end
end
