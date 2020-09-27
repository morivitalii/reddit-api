class Api::Users::Communities::FollowsPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
