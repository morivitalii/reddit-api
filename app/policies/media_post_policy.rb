# frozen_string_literal: true

class MediaPostPolicy < ApplicationPolicy
  def create?(sub)
    return false if banned?(sub)

    user?
  end
end
