# frozen_string_literal: true

class LinkPolicy < ApplicationPolicy
  def create?(sub)
    return false if banned?(sub)

    user?
  end
end
