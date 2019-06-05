# frozen_string_literal: true

class GlobalBlacklistedDomainsPolicy < ApplicationPolicy
  def index?
    staff?
  end

  alias create? index?
  alias destroy? index?
end
