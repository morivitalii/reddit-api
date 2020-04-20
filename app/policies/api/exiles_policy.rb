class Api::ExilesPolicy < ApplicationPolicy
  def index?
    !exiled?
  end

  def show?
    !exiled?
  end

  def create?
    admin?
  end

  def destroy?
    admin?
  end

  def permitted_attributes_for_create
    [:user_id]
  end
end
