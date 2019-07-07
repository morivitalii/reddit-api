# frozen_string_literal: true

class UserModQueuePolicy < ApplicationPolicy
  def index?
    return false unless user?

    staff? || user.id == record.id && record.moderator?
  end
end
