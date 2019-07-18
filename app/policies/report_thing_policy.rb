# frozen_string_literal: true

class ReportThingPolicy < ApplicationPolicy
  def index?
    user_signed_in? && context.user.moderator?(record.sub)
  end

  def create?
    user_signed_in?
  end

  alias new? create?
end
