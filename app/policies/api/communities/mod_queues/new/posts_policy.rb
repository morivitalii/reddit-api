class Api::Communities::ModQueues::New::PostsPolicy < ApplicationPolicy
  def index?
    user? && (admin? || moderator?)
  end
end
