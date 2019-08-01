# frozen_string_literal: true

class TagPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    return false unless user_signed_in?
    return true if user_global_moderator?

    sub_context? ? user_sub_moderator? : false
  end

  alias new? create?

  def update?
    return false unless user_signed_in?
    return true if user_global_moderator?

    sub_context? ? user_sub_moderator? : false
  end

  alias edit? update?

  def destroy?
    return false unless user_signed_in?
    return true if user_global_moderator?

    sub_context? ? user_sub_moderator? : false
  end

  def permitted_attributes_for_create
    [:title]
  end

  def permitted_attributes_for_update
    [:title]
  end
end
