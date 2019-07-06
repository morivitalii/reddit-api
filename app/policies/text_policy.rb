# frozen_string_literal: true

class TextPolicy < ApplicationPolicy
  def create?(sub)
    return false if banned_in_sub?(sub)

    user?
  end

  def update?(thing)
    return false unless user?
    return false if banned_in_sub?(thing.sub)

    thing.user_id == Current.user.id
  end
end
