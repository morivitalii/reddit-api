# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def create?
    return false if banned?(record)

    user?
  end

  def update?
    return false unless user?
    return false if banned?(record.sub)

    record.user_id == user.id
  end

  alias new? create?
  alias edit? update?
end
