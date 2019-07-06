# frozen_string_literal: true

class SpoilerThingPolicy < ApplicationPolicy
  def create?
    staff? || sub_moderator?(record.sub)
  end

  alias destroy? create?
end
