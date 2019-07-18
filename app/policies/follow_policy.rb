# frozen_string_literal: true

class FollowPolicy < ApplicationPolicy
  def create?
    user_signed_in?
  end

  alias destroy? create?
end
