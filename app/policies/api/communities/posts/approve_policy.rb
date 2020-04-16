class Api::Communities::Posts::ApprovePolicy < ApplicationPolicy
  def update?
    admin? || (!exiled? && moderator?)
  end
end
