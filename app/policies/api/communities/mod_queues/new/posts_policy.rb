class Api::Communities::ModQueues::New::PostsPolicy < ApplicationPolicy
  def index?
    moderator? && !banned?
  end
end
