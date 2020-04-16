class Api::Users::Votes::Ups::PostsPolicy < ApplicationPolicy
  def index?
    user? && !exiled? && user.id == record.id
  end
end
