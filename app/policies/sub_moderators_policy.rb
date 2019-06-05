# frozen_string_literal: true

class SubModeratorsPolicy < ApplicationPolicy
  def create?(sub)
    staff? || master?(sub)
  end

  alias update? create?
  alias destroy? create?
end
