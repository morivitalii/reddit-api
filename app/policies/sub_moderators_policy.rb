# frozen_string_literal: true

class SubModeratorsPolicy < ApplicationPolicy
  def create?(sub)
    staff? || sub_master?(sub)
  end

  alias update? create?
  alias destroy? create?
end
