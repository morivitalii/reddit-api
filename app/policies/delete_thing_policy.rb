# frozen_string_literal: true

class DeleteThingPolicy < ApplicationPolicy
  def create?(thing)
    return false unless user?

    staff? || moderator?(thing.sub) || thing.user_id == Current.user.id
  end
end
