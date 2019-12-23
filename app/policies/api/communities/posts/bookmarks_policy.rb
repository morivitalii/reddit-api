class Api::Communities::Posts::BookmarksPolicy < ApplicationPolicy
  def create?
    user?
  end

  alias destroy? create?
end
