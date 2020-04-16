class Api::Users::Votes::Ups::CommentsPolicy < ApplicationPolicy
  def index?
    user? && !exiled? && user.id == record.id
  end
end
