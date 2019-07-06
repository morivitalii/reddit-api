# frozen_string_literal: true

class BlacklistedDomainsPolicy < ApplicationPolicy
  def index?
    staff?
  end

  alias new? index?
  alias create? index?
  alias confirm? index?
  alias destroy? index?
end
