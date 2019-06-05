# frozen_string_literal: true

class SubPagesPolicy < ApplicationPolicy
  def create?(sub)
    staff? || moderator?(sub)
  end

  alias update? create?
  alias destroy? create?
end
