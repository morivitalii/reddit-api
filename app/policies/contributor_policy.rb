# frozen_string_literal: true

class ContributorPolicy < ApplicationPolicy
  def index?
    true
  end

  def search?
    true
  end

  def create?
    user_signed_in? && (user_global_moderator? || user_sub_moderator?)
  end

  alias new? create?

  def destroy?
    user_signed_in? && (user_global_moderator? || user_sub_moderator?)
  end

  def permitted_attributes_for_create
    [:username]
  end
end
