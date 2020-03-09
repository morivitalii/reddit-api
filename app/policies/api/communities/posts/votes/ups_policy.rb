class Api::Communities::Posts::Votes::UpsPolicy < ApplicationPolicy
  def create?
    user? && !muted? && !banned?
  end

  def destroy?
    user? && !muted? && !banned?
  end
end
