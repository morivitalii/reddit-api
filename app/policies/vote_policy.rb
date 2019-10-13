# frozen_string_literal

class VotePolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end

  def permitted_attributes_for_create
    [:type]
  end
end
