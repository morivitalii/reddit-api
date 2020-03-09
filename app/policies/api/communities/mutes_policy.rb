class Api::Communities::MutesPolicy < ApplicationPolicy
  def index?
    !banned?
  end

  def create?
    moderator?
  end

  def update?
    moderator?
  end

  def destroy?
    moderator?
  end

  def permitted_attributes_for_create
    [:username, :reason, :days, :permanent]
  end

  def permitted_attributes_for_update
    [:reason, :days, :permanent]
  end
end
