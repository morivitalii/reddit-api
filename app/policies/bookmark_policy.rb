# frozen_string_literal: true

class BookmarkPolicy < ApplicationPolicy
  def posts_index?
    # record here is user object
    user? && user.id == record.id
  end

  alias comments_index? posts_index?

  def create?
    user?
  end

  def destroy?
    user?
  end
end