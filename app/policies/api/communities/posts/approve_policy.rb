class Api::Communities::Posts::ApprovePolicy < ApplicationPolicy
  def update?
    moderator? && !banned?
  end
end
