# frozen_string_literal: true

class MediaPolicy < ApplicationPolicy
  def create?(sub)
    return false if banned?(sub)

    user?
  end
end
