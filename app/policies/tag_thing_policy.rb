# frozen_string_literal: true

class TagThingPolicy < ApplicationPolicy
  def update?
    user_signed_in? && context.user.moderator?(record.sub) && record.post?
  end

  alias edit? update?
end
