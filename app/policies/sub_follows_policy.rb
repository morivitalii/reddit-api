# frozen_string_literal: true

class SubFollowsPolicy < ApplicationPolicy
  def create?
    user?
  end

  alias destroy? create?
end
