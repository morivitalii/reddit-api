# frozen_string_literal: true

class SubBlacklistedDomainsPolicy < ApplicationPolicy
  def index?(sub)
    staff? || moderator?(sub)
  end

  alias create? index?
  alias destroy? index?
end
