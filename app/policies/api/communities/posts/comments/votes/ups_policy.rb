class Api::Communities::Posts::Comments::Votes::UpsPolicy < ApplicationPolicy
  def create?
    user? && !exiled? && !muted? && !banned?
  end

  def destroy?
    user? && !exiled? && !muted? && !banned?
  end
end
