class Api::Communities::BansPolicy < ApplicationPolicy
  def index?
    !banned?
  end

  def create?
    moderator? && !banned?
  end

  alias new? create?

  def update?
    moderator? && !banned?
  end

  alias edit? update?

  def destroy?
    moderator? && !banned?
  end

  def permitted_attributes_for_create
    [:username, :reason, :days, :permanent]
  end

  def permitted_attributes_for_update
    [:reason, :days, :permanent]
  end
end
