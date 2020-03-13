class Api::Communities::Posts::SpoilerPolicy < ApplicationPolicy
  def create?
    moderator? && !banned?
  end

  def destroy?
    moderator? && !banned?
  end
end
