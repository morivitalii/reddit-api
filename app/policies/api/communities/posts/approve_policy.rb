class Api::Communities::Posts::ApprovePolicy < ApplicationPolicy
  def update?
    user? && (admin? || moderator?)
  end
end
