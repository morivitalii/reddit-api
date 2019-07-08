# frozen_string_literal: true

class BookmarkPolicy < ApplicationPolicy
  def index?
    user?
  end

  alias create? index?
  alias destroy? index?
end