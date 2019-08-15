# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def posts?
    true
  end

  alias comments? posts?

  def update?
    user?
  end

  alias edit? update?

  def permitted_attributes_for_update
    [:email, :password, :password_current]
  end
end