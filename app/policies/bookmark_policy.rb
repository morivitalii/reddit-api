# frozen_string_literal: true

class BookmarkPolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end
end
