# frozen_string_literal: true

class SubPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    global_moderator? || sub_moderator?(record)
  end

  alias edit? update?
end
