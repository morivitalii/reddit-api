class Api::Users::CommentsPolicy < ApplicationPolicy
  def index?
    true
  end
end
