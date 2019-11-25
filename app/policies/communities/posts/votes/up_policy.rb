class Communities::Posts::Votes::UpPolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end
end
