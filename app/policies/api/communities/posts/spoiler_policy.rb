class Api::Communities::Posts::SpoilerPolicy < ApplicationPolicy
  def create?
    moderator?
  end

  def destroy?
    moderator?
  end
end
