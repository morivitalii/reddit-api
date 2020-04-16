class Api::Communities::Posts::BookmarksPolicy < ApplicationPolicy
  def create?
    user? && !exiled? && !banned?
  end

  def destroy?
    user? && !exiled? && !banned?
  end
end
