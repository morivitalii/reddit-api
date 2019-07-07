# frozen_string_literal: true

class ThingSubscriptionPolicy < ApplicationPolicy
  def create?
    return unless user?

    record.user_id == user.id
  end

  alias destroy? create?
end
