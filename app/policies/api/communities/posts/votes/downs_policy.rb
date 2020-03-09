class Api::Communities::Posts::Votes::DownsPolicy < ApplicationPolicy
  def create?
    user? && !muted? && !banned?
  end

  def destroy?
    user? && !muted? && !banned?
  end
end
