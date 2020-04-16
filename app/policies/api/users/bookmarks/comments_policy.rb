class Api::Users::Bookmarks::CommentsPolicy < ApplicationPolicy
  def index?
    user? && !exiled? && user.id == record.id
  end
end
