class Api::Users::Votes::Downs::PostsPolicy < ApplicationPolicy
  def index?
    user? && !exiled? && user.id == record.id
  end
end
