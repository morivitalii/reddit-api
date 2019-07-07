# frozen_string_literal: true

class SubBlacklistedDomainPolicy < ApplicationPolicy
  def index?
    staff? || sub_moderator?(record)
  end

  alias search? index?
  alias new? index?
  alias create? index?
  alias confirm? index?
  alias destroy? index?
end
