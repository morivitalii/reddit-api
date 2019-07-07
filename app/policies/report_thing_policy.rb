# frozen_string_literal: true

class ReportThingPolicy < ApplicationPolicy
  def index?
    staff? || sub_moderator?(record)
  end

  def create?
    user?
  end
end
