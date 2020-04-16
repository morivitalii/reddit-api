class Api::Users::Votes::PostsPolicy < ApplicationPolicy
  def index?
    user? && !exiled? && user.id == record.id
  end
end
