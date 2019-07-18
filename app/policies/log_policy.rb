# frozen_string_literal: true

class LogPolicy < ApplicationPolicy
  def index?
    user_signed_in? && context.user.moderator?(context.sub)
  end
end
