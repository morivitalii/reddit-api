class Api::UsersPolicy < ApplicationPolicy
  def index?
    !exiled?
  end

  def show?
    !exiled?
  end

  def update?
    user? && !exiled?
  end

  def permitted_attributes_for_update
    [:email, :password]
  end
end
