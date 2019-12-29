class Api::UsersPolicy < ApplicationPolicy
  def update?
    user?
  end

  def permitted_attributes_for_update
    [:email, :password, :password_current]
  end
end
