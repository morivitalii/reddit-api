# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  alias comments? show?

  def update?
    user_signed_in?
  end

  alias edit? update?

  def permitted_attributes_for_update
    [:email, :password, :password_current]
  end
end