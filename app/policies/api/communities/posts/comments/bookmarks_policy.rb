class Api::Communities::Posts::Comments::BookmarksPolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end
end
