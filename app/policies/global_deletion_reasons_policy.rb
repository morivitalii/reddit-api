# frozen_string_literal: true

class GlobalDeletionReasonsPolicy < ApplicationPolicy
  def index?
    staff?
  end

  alias create? index?
  alias update? index?
  alias destroy? index?
end
