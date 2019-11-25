class Communities::Posts::Comments::Votes::UpPolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end
end
