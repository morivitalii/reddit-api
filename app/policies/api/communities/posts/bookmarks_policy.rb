class Api::Communities::Posts::BookmarksPolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end
end
