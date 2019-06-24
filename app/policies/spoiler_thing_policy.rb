# frozen_string_literal: true

class SpoilerThingPolicy < ApplicationPolicy
  def create?(thing)
    staff? || moderator?(thing.sub)
  end

  alias destroy? create?
end
