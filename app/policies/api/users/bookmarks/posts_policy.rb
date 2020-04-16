class Api::Users::Bookmarks::PostsPolicy < ApplicationPolicy
  def index?
    user? && !exiled? && user.id == record.id
  end
end
