class Api::Communities::ModQueues::Reports::CommentsPolicy < ApplicationPolicy
  def index?
    moderator?
  end
end
