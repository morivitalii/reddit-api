class Api::Communities::Posts::Comments::ReportsPolicy < ApplicationPolicy
  def index?
    admin? || (!exiled? && moderator?)
  end

  def show?
    admin? || (!exiled? && moderator?)
  end

  def create?
    user? && (admin? || (!exiled? && !muted? && !banned?))
  end

  def destroy?
    admin? || (!exiled? && moderator?)
  end

  def permitted_attributes_for_create
    [:text]
  end
end
