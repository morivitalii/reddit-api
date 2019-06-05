# frozen_string_literal: true

class ThingApprovePolicy < ApplicationPolicy
  def create?(thing)
    staff? || moderator?(thing.sub)
  end
end
