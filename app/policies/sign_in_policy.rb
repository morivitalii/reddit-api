# frozen_string_literal: true

class SignInPolicy < ApplicationPolicy
  def create?
    visitor?
  end

  alias new? create?
  alias unauthenticated? create?
end
