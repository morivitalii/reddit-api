class Communities::Posts::Comments::BookmarksPolicy < ApplicationPolicy
  def create?
    user?
  end

  alias destroy? create?
end
