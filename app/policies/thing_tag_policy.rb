# frozen_string_literal: true

class ThingTagPolicy < ApplicationPolicy
  def update?(thing)
    staff? || moderator?(thing.sub)
  end
end
