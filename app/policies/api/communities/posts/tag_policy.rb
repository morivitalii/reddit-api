class Api::Communities::Posts::TagPolicy < ApplicationPolicy
  def update?
    admin? || (!exiled? && moderator?)
  end

  def permitted_attributes_for_update
    [:tag]
  end
end
