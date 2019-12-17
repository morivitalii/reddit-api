class SignInPolicy < ApplicationPolicy
  def create?
    visitor?
  end

  alias unauthenticated? create?
end
