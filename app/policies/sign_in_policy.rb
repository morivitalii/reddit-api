# frozen_string_literal: true

class SignInPolicy < ApplicationPolicy
  def create?
    user_signed_out?
  end

  alias new? create?
end