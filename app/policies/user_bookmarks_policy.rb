# frozen_string_literal: true

class UserBookmarksPolicy < ApplicationPolicy
  def index?(user)
    return false unless user?

    staff? || Current.user.id == user.id
  end
end
