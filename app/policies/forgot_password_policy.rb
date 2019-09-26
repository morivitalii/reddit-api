# frozen_string_literal: true

class ForgotPasswordPolicy < ApplicationPolicy
  def create?
    true
  end

  alias new? create?

  def permitted_attributes_for_create
    [:email]
  end
end
