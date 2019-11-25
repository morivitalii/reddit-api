class Users::Votes::Ups::PostsPolicy < ApplicationPolicy
  def index?
    # record here is user object
    user? && user.id == record.id
  end
end
