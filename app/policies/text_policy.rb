# frozen_string_literal: true

class TextPolicy < ApplicationPolicy
  def create?(sub)
    return false if banned?(sub)

    user?
  end

  def update?(thing)
    return false unless user?
    return false if banned?(thing.sub)

    thing.user_id == Current.user.id
  end
end
