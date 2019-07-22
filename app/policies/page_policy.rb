# frozen_string_literal: true

class PagePolicy < ApplicationPolicy
  def index?
    true
  end

  alias show? index?

  def new?
    user_signed_in? && context.user.moderator?(context.sub)
  end
  
  alias create? index?
  alias edit? index?
  alias update? index?
  alias destroy? index?
end
