# frozen_string_literal: true

class SpoilerThingPolicy < ApplicationPolicy
  def create?
    staff? || moderator?(record.sub)
  end

  alias destroy? create?
end
