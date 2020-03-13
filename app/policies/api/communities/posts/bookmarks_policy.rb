class Api::Communities::Posts::BookmarksPolicy < ApplicationPolicy
  def create?
    user? && !banned?
  end

  def destroy?
    user? && !banned?
  end
end
