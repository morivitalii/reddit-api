class Api::Communities::Posts::Comments::ApprovePolicy < ApplicationPolicy
  def update?
    user? && (admin? || moderator?)
  end
end
