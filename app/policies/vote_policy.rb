# frozen_string_literal

class VotePolicy < ApplicationPolicy
  def index?
    user?
  end

  alias create? index?
  alias destroy? index?
end