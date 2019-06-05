# frozen_string_literal: true

class ThingNotificationsPolicy < ApplicationPolicy
  def create?(thing)
    return unless user?

    thing.user_id == Current.user.id
  end

  alias destroy? create?
end
