# frozen_string_literal: true

class ThingIgnoreReportsPolicy < ApplicationPolicy
  def create?(thing)
    staff? || moderator?(thing.sub)
  end

  alias destroy? create?
end