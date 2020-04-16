class Api::Communities::ModQueues::New::CommentsPolicy < ApplicationPolicy
  def index?
    admin? || (!exiled? && moderator?)
  end
end
