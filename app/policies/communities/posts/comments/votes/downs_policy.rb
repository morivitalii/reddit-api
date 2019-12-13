class Communities::Posts::Comments::Votes::DownsPolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end
end
