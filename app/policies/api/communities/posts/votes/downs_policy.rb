class Api::Communities::Posts::Votes::DownsPolicy < ApplicationPolicy
  def create?
    user? && !muted?
  end

  def destroy?
    user? && !muted?
  end
end
