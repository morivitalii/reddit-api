class Api::Communities::ModQueues::New::PostsPolicy < ApplicationPolicy
  def index?
    admin? || (!exiled? && moderator?)
  end
end
