class Api::Communities::Posts::Comments::Votes::UpsPolicy < ApplicationPolicy
  def create?
    user? && !muted?
  end

  def destroy?
    user? && !muted?
  end
end
