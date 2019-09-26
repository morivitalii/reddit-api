# frozen_string_literal

class VotePolicy < ApplicationPolicy
  def index?
    # record here is user object
    user? && user.id == record.id
  end

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
