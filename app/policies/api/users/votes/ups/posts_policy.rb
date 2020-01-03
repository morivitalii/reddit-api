class Api::Users::Votes::Ups::PostsPolicy < ApplicationPolicy
  def index?
    user? && user.id == record.id
  end
end
