# frozen_string_literal: true

class IgnoreThingReportsPolicy < ApplicationPolicy
  def create?
    staff? || moderator?(record.sub)
  end

  alias destroy? create?
end