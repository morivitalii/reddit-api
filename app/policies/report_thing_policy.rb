# frozen_string_literal: true

class ReportThingPolicy < ApplicationPolicy
  def index?(sub)
    staff? || moderator?(sub)
  end

  def create?
    user?
  end
end
