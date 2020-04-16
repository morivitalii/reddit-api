class Api::Users::Votes::Downs::CommentsPolicy < ApplicationPolicy
  def index?
    user? && !exiled? && user.id == record.id
  end
end
