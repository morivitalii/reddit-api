# frozen_string_literal: true

class GlobalBansPolicy < ApplicationPolicy
  def index?
    staff?
  end

  alias create? index?
  alias update? index?
  alias destroy? index?
end
