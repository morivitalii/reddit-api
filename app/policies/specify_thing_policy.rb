# frozen_string_literal: true

class SpecifyThingPolicy < ApplicationPolicy
  def create?
    record.post? && (global_moderator? || sub_moderator?(record.sub))
  end

  alias destroy? create?
end
