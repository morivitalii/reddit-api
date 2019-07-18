# frozen_string_literal: true

class BanPolicy < ApplicationPolicy
  def index?
    user_signed_in? && context.user.moderator?(context.sub)
  end

  alias search? index?
  alias new? index?
  alias create? index?
  alias edit? index?
  alias update? index?
  alias confirm? index?
  alias destroy? index?
end
