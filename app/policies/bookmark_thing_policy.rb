# frozen_string_literal: true

class BookmarkThingPolicy < ApplicationPolicy
  def create?
    user?
  end

  alias destroy? create?
end
