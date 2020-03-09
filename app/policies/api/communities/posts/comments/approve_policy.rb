class Api::Communities::Posts::Comments::ApprovePolicy < ApplicationPolicy
  def update?
    moderator? && !banned?
  end
end
