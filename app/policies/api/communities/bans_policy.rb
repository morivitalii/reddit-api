class Api::Communities::BansPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    moderator?
  end

  alias new? create?

  def update?
    moderator?
  end

  alias edit? update?

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
