class Api::UsersPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    user?
  end

  def permitted_attributes_for_update
    [:email, :password]
  end
end
