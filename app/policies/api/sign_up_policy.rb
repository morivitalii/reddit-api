class Api::SignUpPolicy < ApplicationPolicy
  def create?
    visitor?
  end

  def permitted_attributes_for_create
    [:username, :email, :password]
  end
end
