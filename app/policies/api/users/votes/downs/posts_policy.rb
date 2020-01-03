class Api::Users::Votes::Downs::PostsPolicy < ApplicationPolicy
  def index?
    user? && user.id == record.id
  end
end
