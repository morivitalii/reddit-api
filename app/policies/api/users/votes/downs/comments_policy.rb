class Api::Users::Votes::Downs::CommentsPolicy < ApplicationPolicy
  def index?
    user? && user.id == record.id
  end
end
