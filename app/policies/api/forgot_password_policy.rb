class Api::ForgotPasswordPolicy < ApplicationPolicy
  def create?
    true
  end

  def permitted_attributes_for_create
    [:email]
  end
end
