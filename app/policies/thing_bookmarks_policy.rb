# frozen_string_literal: true

class ThingBookmarksPolicy < ApplicationPolicy
  def create?
    user?
  end

  alias destroy? create?
end
