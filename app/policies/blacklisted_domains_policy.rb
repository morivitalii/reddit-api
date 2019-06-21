# frozen_string_literal: true

class BlacklistedDomainsPolicy < ApplicationPolicy
  def index?
    staff?
  end

  alias create? index?
  alias destroy? index?
end
