# frozen_string_literal: true

class SignOutPolicy < ApplicationPolicy
  def destroy?
    user?
  end
end