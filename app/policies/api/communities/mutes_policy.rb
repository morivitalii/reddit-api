class Api::Communities::MutesPolicy < ApplicationPolicy
  def index?
    user? && (admin? || moderator?)
  end

  def create?
    user? && (admin? || moderator?)
  end

  def update?
    user? && (admin? || moderator?)
  end

  def destroy?
    user? && (admin? || moderator?)
  end

  def permitted_attributes_for_create
    [:username, :reason, :days, :permanent]
  end

  def permitted_attributes_for_update
    [:reason, :days, :permanent]
  end
end
