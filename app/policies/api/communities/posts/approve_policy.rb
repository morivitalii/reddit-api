class Api::Communities::Posts::ApprovePolicy < ApplicationPolicy
  def update?
    moderator?
  end
end