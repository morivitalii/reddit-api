# frozen_string_literal: true

class SubPagePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    staff? || sub_moderator?(record)
  end

  alias new? create?
  alias edit? create?
  alias update? create?
  alias confirm? create?
  alias destroy? create?
end
