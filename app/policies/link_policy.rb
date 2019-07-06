# frozen_string_literal: true

class LinkPolicy < ApplicationPolicy
  def create?
    return false if banned_in_sub?(record)

    user?
  end
end
