# frozen_string_literal: true

class BlacklistedDomainPolicy < ApplicationPolicy
  def index?
    user_signed_in? && context.user.moderator?(context.sub)
  end

  alias search? index?
  alias new? index?
  alias create? index?
  alias destroy? index?
end
