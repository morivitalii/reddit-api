class Api::ChangePasswordPolicy < ApplicationPolicy
  def update?
    !exiled?
  end

  def permitted_attributes_for_update
    [:token, :password]
  end
end
