# frozen_string_literal: true

class ReportThingPolicy < ApplicationPolicy
  def index?
    global_moderator? || sub_moderator?(record.sub)
  end

  def create?
    user?
  end

  alias new? create?
end
