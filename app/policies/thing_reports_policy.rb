# frozen_string_literal: true

class ThingReportsPolicy < ApplicationPolicy
  def index?(sub)
    staff? || moderator?(sub)
  end

  def create?
    user?
  end
end
