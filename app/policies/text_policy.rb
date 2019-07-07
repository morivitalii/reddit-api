# frozen_string_literal: true

class TextPolicy < ApplicationPolicy
  def create?
    return false if banned_in_sub?(record)

    user?
  end

  alias new? create?

  def update?
    return false unless user?
    return false if banned_in_sub?(record.sub)

    record.user_id == user.id
  end

  alias edit? update?
end
