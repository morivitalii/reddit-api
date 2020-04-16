class Api::Users::Votes::CommentsPolicy < ApplicationPolicy
  def index?
    user? && !exiled? && user.id == record.id
  end
end
