class Api::Communities::Posts::Comments::ReportsPolicy < ApplicationPolicy
  def index?
    admin? || (!exiled? && moderator?)
  end

  def create?
    user? && (admin? || (!exiled? && !muted? && !banned?))
  end

  def permitted_attributes_for_create
    [:text]
  end
end
