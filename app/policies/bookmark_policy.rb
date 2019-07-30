# frozen_string_literal: true

class BookmarkPolicy < ApplicationPolicy
  def index?
    user_signed_in?
  end

  def comments?
    user_signed_in?
  end

  alias create? index?
  alias destroy? index?
end