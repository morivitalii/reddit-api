# frozen_string_literal: true

class ApproveThingPolicy < ApplicationPolicy
  def create?
    staff? || sub_moderator?(record.sub)
  end
end
