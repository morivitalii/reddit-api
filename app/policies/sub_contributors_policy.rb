# frozen_string_literal: true

class SubContributorsPolicy < ApplicationPolicy
  def index?(sub)
    staff? || moderator?(sub)
  end

  alias create? index?
  alias update? index?
  alias destroy? index?
end
