class Api::ForgotPasswordPolicy < ApplicationPolicy
  def create?
    !exiled?
  end

  def permitted_attributes_for_create
    [:email]
  end
end
