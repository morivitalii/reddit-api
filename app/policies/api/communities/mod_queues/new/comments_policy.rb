class Api::Communities::ModQueues::New::CommentsPolicy < ApplicationPolicy
  def index?
    user? && (admin? || moderator?)
  end
end
