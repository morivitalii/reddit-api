# frozen_string_literal: true

class BlacklistedDomainPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user_signed_in? && user_moderator?
  end

  alias new? create?

  def destroy?
    user_signed_in? && user_moderator?
  end

  def permitted_attributes_for_create
    [:domain]
  end
end
