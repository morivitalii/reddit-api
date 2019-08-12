# frozen_string_literal: true

class SubPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    user_signed_in? && user_moderator?
  end

  alias edit? update?

  def permitted_attributes_for_update
    [:title, :description]
  end
end
