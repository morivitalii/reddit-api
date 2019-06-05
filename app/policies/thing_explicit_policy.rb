# frozen_string_literal: true

class ThingExplicitPolicy < ApplicationPolicy
  def create?(thing)
    staff? || moderator?(thing.sub)
  end

  alias destroy? create?
end
