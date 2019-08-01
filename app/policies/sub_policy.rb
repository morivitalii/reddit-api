# frozen_string_literal: true

class SubPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    return false unless user_signed_in?
    return true if user_global_moderator?

    user_sub_moderator?
  end

  alias edit? update?

  def permitted_attributes_for_update
    [:title, :description]
  end
end
