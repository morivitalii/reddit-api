# frozen_string_literal: true

class BookmarkPolicy < ApplicationPolicy
  def posts?
    user?
  end

  alias comments? posts?

  def create?
    user?
  end

  def destroy?
    user?
  end
end