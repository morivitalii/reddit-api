# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    user_signed_in?
  end

  alias edit? update?
end