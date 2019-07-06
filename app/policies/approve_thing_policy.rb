# frozen_string_literal: true

class ApproveThingPolicy < ApplicationPolicy
  def create?
    staff? || moderator?(record.sub)
  end
end
