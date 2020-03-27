class Api::Communities::ModQueues::Reports::CommentsPolicy < ApplicationPolicy
  def index?
    user? && (admin? || moderator?)
  end
end
