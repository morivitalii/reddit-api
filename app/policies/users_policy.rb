class UsersPolicy < ApplicationPolicy
  def update?
    user?
  end

  alias edit? update?

  def permitted_attributes_for_update
    [:email, :password, :password_current]
  end
end
