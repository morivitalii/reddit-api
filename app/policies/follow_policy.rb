# frozen_string_literal: true

class FollowPolicy < ApplicationPolicy
  def create?
    user?
  end

  alias destroy? create?
end
