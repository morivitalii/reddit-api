# frozen_string_literal: true

class BookmarkPolicy < ApplicationPolicy
  def index?
    # record here is user object
    user? && user.id == record.id
  end

  def create?
    user?
  end

  def destroy?
    user?
  end
end