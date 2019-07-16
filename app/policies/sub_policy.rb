# frozen_string_literal: true

class SubPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    global_moderator? || sub_master?(record)
  end

  alias edit? update?
end
