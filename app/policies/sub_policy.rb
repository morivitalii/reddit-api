# frozen_string_literal: true

class SubPolicy < ApplicationPolicy
  def index?
    true
  end

  alias show? index?

  def update?
    staff? || sub_master?(record)
  end

  alias edit? update?
end
