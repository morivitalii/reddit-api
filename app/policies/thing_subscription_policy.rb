# frozen_string_literal: true

class ThingSubscriptionPolicy < ApplicationPolicy
  def create?
    user_signed_in? && record.user_id == context.user.id
  end

  alias destroy? create?
end
