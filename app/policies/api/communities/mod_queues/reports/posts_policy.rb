class Api::Communities::ModQueues::Reports::PostsPolicy < ApplicationPolicy
  def index?
    moderator? && !banned?
  end
end
