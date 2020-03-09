class Api::Communities::Posts::Comments::BookmarksPolicy < ApplicationPolicy
  def create?
    user? && !banned?
  end

  def destroy?
    user? && !banned?
  end
end
