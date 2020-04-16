class Api::Communities::ModQueues::Reports::PostsPolicy < ApplicationPolicy
  def index?
    admin? || (!exiled? && moderator?)
  end
end
