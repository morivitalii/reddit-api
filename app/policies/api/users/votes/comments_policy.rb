class Api::Users::Votes::CommentsPolicy < ApplicationPolicy
  def index?
    user? && user.id == record.id
  end
end
