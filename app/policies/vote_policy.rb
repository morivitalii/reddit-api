# frozen_string_literal

class VotePolicy < ApplicationPolicy
  def posts?
    user_signed_in?
  end

  alias comments? posts?

  def create?
    user_signed_in?
  end

  def destroy?
    user_signed_in?
  end

  def permitted_attributes_for_create
    [:type]
  end
end