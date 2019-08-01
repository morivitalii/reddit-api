# frozen_string_literal: true

class SignOutPolicy < ApplicationPolicy
  def destroy?
    user_signed_in?
  end
end