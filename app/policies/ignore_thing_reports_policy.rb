# frozen_string_literal: true

class IgnoreThingReportsPolicy < ApplicationPolicy
  def create?
    user_signed_in? && context.user.moderator?(record.sub)
  end

  alias destroy? create?
end