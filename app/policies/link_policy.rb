# frozen_string_literal: true

class LinkPolicy < ApplicationPolicy
  def create?
    return false if banned?(record)

    user?
  end
end
