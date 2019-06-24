# frozen_string_literal: true

class ApproveThingPolicy < ApplicationPolicy
  def create?(thing)
    staff? || moderator?(thing.sub)
  end
end
