# frozen_string_literal: true

class VoteThingPolicy < ApplicationPolicy
  def create?
    user?
  end
end
