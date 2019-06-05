# frozen_string_literal: true

class ThingVotePolicy < ApplicationPolicy
  def create?
    user?
  end
end
