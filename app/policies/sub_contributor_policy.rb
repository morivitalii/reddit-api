# frozen_string_literal: true

class SubContributorPolicy < ApplicationPolicy
  def index?
    staff? || sub_moderator?(record)
  end

  alias search? index?
  alias new? index?
  alias create? index?
  alias edit? index?
  alias update? index?
  alias confirm? index?
  alias destroy? index?
end
