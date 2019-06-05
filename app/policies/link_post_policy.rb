# frozen_string_literal: true

class LinkPostPolicy < ApplicationPolicy
  def create?(sub)
    return false if banned?(sub)

    user?
  end
end
