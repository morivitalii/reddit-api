# frozen_string_literal: true

class BookmarkPolicy < ApplicationPolicy
  def posts?
    user_signed_in?
  end

  alias comments? posts?

  def create?
    user_signed_in?
  end

  def destroy?
    user_signed_in?
  end
end