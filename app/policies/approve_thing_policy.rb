# frozen_string_literal: true

class ApproveThingPolicy < ApplicationPolicy
  def create?
    user_signed_in? && context.user.moderator?(record.sub)
  end
end
