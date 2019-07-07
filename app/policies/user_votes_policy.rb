# frozen_string_literal: true

class UserVotesPolicy < ApplicationPolicy
  def index?
    return false unless user?

    staff? || user.id == record.id
  end
end
