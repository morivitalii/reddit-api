class Api::Communities::Posts::ExplicitPolicy < ApplicationPolicy
  def create?
    moderator? && !banned?
  end

  def destroy?
    moderator? && !banned?
  end
end
