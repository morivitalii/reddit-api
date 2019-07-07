# frozen_string_literal: true

class SubModeratorPolicy < ApplicationPolicy
  def index?
    true
  end

  alias search? index?

  def create?
    staff? || sub_master?(record)
  end

  alias new? create?
  alias edit? create?
  alias update? create?
  alias confirm? create?
  alias destroy? create?
end
