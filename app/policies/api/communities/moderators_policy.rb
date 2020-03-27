class Api::Communities::ModeratorsPolicy < ApplicationPolicy
  def index?
    !banned?
  end

  def create?
    user? && (admin? || moderator?)
  end

  def destroy?
    user? && (admin? || moderator?)
  end

  def permitted_attributes_for_create
    [:username]
  end
end
