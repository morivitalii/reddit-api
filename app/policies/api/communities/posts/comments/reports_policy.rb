class Api::Communities::Posts::Comments::ReportsPolicy < ApplicationPolicy
  def index?
    user? && (admin? || moderator?)
  end

  def create?
    user? && (admin? || (!muted? && !banned?))
  end

  def permitted_attributes_for_create
    [:text]
  end
end
