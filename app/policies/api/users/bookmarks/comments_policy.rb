class Api::Users::Bookmarks::CommentsPolicy < ApplicationPolicy
  def index?
    user? && user.id == record.id
  end
end
