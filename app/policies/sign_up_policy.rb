# frozen_string_literal: true

class SignUpPolicy < ApplicationPolicy
  def create?
    user_signed_out?
  end

  alias new? create?

  def permitted_attributes_for_create
    [:username, :email, :password]
  end
end