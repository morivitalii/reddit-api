class Communities::Posts::Votes::DownPolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end
end
