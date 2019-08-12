# frozen_string_literal: true

class PagePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
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
    [:title, :text]
  end

  def permitted_attributes_for_update
    [:title, :text]
  end
end
