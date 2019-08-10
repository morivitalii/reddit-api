# frozen_string_literal

class VotePolicy < ApplicationPolicy
  def index?
    user_signed_in?
  end

  alias comments? index?

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