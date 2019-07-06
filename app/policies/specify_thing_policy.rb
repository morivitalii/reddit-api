# frozen_string_literal: true

class SpecifyThingPolicy < ApplicationPolicy
  def create?
    staff? || moderator?(record.sub)
  end

  alias destroy? create?
end
