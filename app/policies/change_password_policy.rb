class ChangePasswordPolicy < ApplicationPolicy
  def update?
    true
  end

  alias edit? update?

  def permitted_attributes_for_update
    [:token, :password]
  end
end
