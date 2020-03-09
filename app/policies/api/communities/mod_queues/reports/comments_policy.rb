class Api::Communities::ModQueues::Reports::CommentsPolicy < ApplicationPolicy
  def index?
    moderator? && !banned?
  end
end
