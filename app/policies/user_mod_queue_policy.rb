# frozen_string_literal: true

class UserModQueuePolicy < ApplicationPolicy
  def index?(user)
    return false unless user?

    staff? || Current.user.id == user.id && user.moderator?
  end
end
