class Api::Users::Bookmarks::PostsPolicy < ApplicationPolicy
  def index?
    user? && user.id == record.id
  end
end
