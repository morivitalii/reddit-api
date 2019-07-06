# frozen_string_literal: true

class BlacklistedDomainPolicy < ApplicationPolicy
  def index?
    staff?
  end

  alias search? index?
  alias new? index?
  alias create? index?
  alias confirm? index?
  alias destroy? index?
end
