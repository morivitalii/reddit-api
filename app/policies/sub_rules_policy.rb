# frozen_string_literal: true

class SubRulesPolicy < ApplicationPolicy
  def index?(sub)
    staff? || master?(sub)
  end

  alias create? index?
  alias update? index?
  alias destroy? index?
end
