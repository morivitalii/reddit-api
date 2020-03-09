class Api::Communities::Posts::Comments::Votes::DownsPolicy < ApplicationPolicy
  def create?
    user? && !muted? && !banned?
  end

  def destroy?
    user? && !muted? && !banned?
  end
end
