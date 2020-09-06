class Api::Communities::BansPolicy < ApplicationPolicy
  def index?
    admin? || (!exiled? && moderator?)
  end

  def show?
    admin? || (!exiled? && moderator?)
  end

  def create?
    admin? || (!exiled? && moderator?)
  end

  def update?
    admin? || (!exiled? && moderator?)
  end

  def destroy?
    admin? || (!exiled? && moderator?)
  end

  def permitted_attributes_for_create
    [:user_id, :end_at]
  end

  def permitted_attributes_for_update
    [:end_at]
  end
end
