# frozen_string_literal: true

class ReportThingPolicy < ApplicationPolicy
  def index?
    staff? || sub_moderator?(record.sub)
  end

  def create?
    user?
  end

  alias new? create?
end
