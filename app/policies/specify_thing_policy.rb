# frozen_string_literal: true

class SpecifyThingPolicy < ApplicationPolicy
  def create?
    user_signed_in? && context.user.moderator?(record.sub) && record.post?
  end

  alias destroy? create?
end
