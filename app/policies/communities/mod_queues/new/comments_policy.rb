class Communities::ModQueues::New::CommentsPolicy < ApplicationPolicy
  def index?
    moderator?
  end
end
