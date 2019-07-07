# frozen_string_literal: true

class UserBookmarksPolicy < ApplicationPolicy
  def index?
    return false unless user?

    staff? || user.id == record.id
  end
end
