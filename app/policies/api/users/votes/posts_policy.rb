class Api::Users::Votes::PostsPolicy < ApplicationPolicy
  def index?
    user? && user.id == record.id
  end
end
