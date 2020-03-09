class Api::Communities::Posts::Votes::UpsPolicy < ApplicationPolicy
  def create?
    user? && !muted?
  end

  def destroy?
    user? && !muted?
  end
end
