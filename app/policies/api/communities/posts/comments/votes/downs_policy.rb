class Api::Communities::Posts::Comments::Votes::DownsPolicy < ApplicationPolicy
  def create?
    user? && !exiled? && !muted? && !banned?
  end

  def destroy?
    user? && !exiled? && !muted? && !banned?
  end
end
