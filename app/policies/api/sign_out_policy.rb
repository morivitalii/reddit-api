class Api::SignOutPolicy < ApplicationPolicy
  def destroy?
    user?
  end
end
