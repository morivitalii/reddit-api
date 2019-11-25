class Communities::Posts::Comments::Votes::DownPolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end
end
