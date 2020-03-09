class Api::Communities::Posts::ExplicitPolicy < ApplicationPolicy
  def create?
    moderator?
  end

  def destroy?
    moderator?
  end
end
