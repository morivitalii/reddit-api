class Api::Communities::ModQueues::Reports::CommentsPolicy < ApplicationPolicy
  def index?
    admin? || (!exiled? && moderator?)
  end
end
