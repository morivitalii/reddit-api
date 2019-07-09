# frozen_string_literal: true

class IgnoreThingReportsPolicy < ApplicationPolicy
  def create?
    global_moderator? || sub_moderator?(record.sub)
  end

  alias destroy? create?
end