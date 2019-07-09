# frozen_string_literal: true

class ApproveThingPolicy < ApplicationPolicy
  def create?
    global_moderator? || sub_moderator?(record.sub)
  end
end
