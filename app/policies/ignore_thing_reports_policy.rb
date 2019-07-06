# frozen_string_literal: true

class IgnoreThingReportsPolicy < ApplicationPolicy
  def create?
    staff? || sub_moderator?(record.sub)
  end

  alias destroy? create?
end