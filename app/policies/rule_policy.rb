# frozen_string_literal: true

class RulePolicy < ApplicationPolicy
  def index?
    user_signed_in? && context.user.moderator?(context.sub)
  end

  alias new? index?
  alias create? index?
  alias edit? index?
  alias update? index?
  alias destroy? index?
end
