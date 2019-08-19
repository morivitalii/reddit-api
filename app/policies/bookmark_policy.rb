# frozen_string_literal: true

class BookmarkPolicy < ApplicationPolicy
  def posts?
    # record here is user object
    user? && user.id == record.id
  end

  alias comments? posts?

  def create?
    user?
  end

  def destroy?
    user?
  end
end