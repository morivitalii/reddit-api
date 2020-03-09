class Api::SignInPolicy < ApplicationPolicy
  def create?
    visitor?
  end

  def unauthenticated?
    visitor?
  end
end
