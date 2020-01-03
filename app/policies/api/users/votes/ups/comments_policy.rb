class Api::Users::Votes::Ups::CommentsPolicy < ApplicationPolicy
  def index?
    user? && user.id == record.id
  end
end
