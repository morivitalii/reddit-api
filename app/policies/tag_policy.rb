# frozen_string_literal: true

class TagPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user_signed_in? && user_moderator?
  end

  alias new? create?

  def update?
    user_signed_in? && user_moderator?
  end

  alias edit? update?

  def destroy?
    user_signed_in? && user_moderator?
  end

  def permitted_attributes_for_create
    [:title]
  end

  def permitted_attributes_for_update
    [:title]
  end
end
