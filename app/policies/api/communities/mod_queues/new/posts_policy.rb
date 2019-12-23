class Api::Communities::ModQueues::New::PostsPolicy < ApplicationPolicy
  def index?
    moderator?
  end
end
