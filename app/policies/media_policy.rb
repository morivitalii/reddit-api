# frozen_string_literal: true

class MediaPolicy < ApplicationPolicy
  def create?
    return false if banned?(record)

    user?
  end
end
