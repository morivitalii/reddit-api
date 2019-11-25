class SignOutPolicy < ApplicationPolicy
  def destroy?
    user?
  end
end
