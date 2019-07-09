# frozen_string_literal: true

class SubPolicy < ApplicationPolicy
  def index?
    true
  end

  alias show? index?

  def update?
    global_moderator? || sub_master?(record)
  end

  alias edit? update?
end
