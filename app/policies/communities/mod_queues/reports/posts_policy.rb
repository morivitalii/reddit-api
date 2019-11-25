class Communities::ModQueues::Reports::PostsPolicy < ApplicationPolicy
  def index?
    moderator?
  end
end
