# frozen_string_literal: true

class SpecifyThingPolicy < ApplicationPolicy
  def create?
    record.post? && (staff? || sub_moderator?(record.sub))
  end

  alias destroy? create?
end
