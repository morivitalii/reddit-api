# frozen_string_literal: true

class TagThingPolicy < ApplicationPolicy
  def update?(thing)
    staff? || sub_moderator?(thing.sub)
  end
end
