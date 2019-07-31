# frozen_string_literal: true

class BookmarkPolicy < ApplicationPolicy
  def index?
    user_signed_in?
  end

  def comments?
    user_signed_in?
  end

  def create?
    user_signed_in?
  end

  def destroy?
    user_signed_in?
  end
end