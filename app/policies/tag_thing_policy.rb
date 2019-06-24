# frozen_string_literal: true

class TagThingPolicy < ApplicationPolicy
  def update?(thing)
    staff? || moderator?(thing.sub)
  end
end
