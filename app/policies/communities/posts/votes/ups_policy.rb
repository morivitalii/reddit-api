class Communities::Posts::Votes::UpsPolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end
end
