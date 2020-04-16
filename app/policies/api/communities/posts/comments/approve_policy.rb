class Api::Communities::Posts::Comments::ApprovePolicy < ApplicationPolicy
  def update?
    admin? || (!exiled? && moderator?)
  end
end
