# frozen_string_literal: true

class ThingSubscriptionPolicy < ApplicationPolicy
  def create?(thing)
    return unless user?

    thing.user_id == Current.user.id
  end

  alias destroy? create?
end
