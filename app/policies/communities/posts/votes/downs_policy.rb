class Communities::Posts::Votes::DownsPolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end
end
