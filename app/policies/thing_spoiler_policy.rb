# frozen_string_literal: true

class ThingSpoilerPolicy < ApplicationPolicy
  def create?(thing)
    staff? || moderator?(thing.sub)
  end

  alias destroy? create?
end
