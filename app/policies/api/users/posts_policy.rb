class Api::Users::PostsPolicy < ApplicationPolicy
  def index?
    true
  end
end
