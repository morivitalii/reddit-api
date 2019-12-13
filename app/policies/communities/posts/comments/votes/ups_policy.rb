class Communities::Posts::Comments::Votes::UpsPolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end
end
