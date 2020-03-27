class Api::Communities::ModQueues::Reports::PostsPolicy < ApplicationPolicy
  def index?
    user? && (admin? || moderator?)
  end
end
