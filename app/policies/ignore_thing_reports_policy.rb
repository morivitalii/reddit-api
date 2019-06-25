# frozen_string_literal: true

class IgnoreThingReportsPolicy < ApplicationPolicy
  def create?(thing)
    staff? || moderator?(thing.sub)
  end

  alias destroy? create?
end