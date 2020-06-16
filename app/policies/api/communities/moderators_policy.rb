class Api::Communities::ModeratorsPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end

  def show?
    !exiled? && !banned?
  end

  def create?
    admin? || moderator?
  end

  def destroy?
    admin? || moderator?
  end

  def permitted_attributes_for_create
    [:user_id]
  end
end
