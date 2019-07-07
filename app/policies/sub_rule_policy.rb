# frozen_string_literal: true

class SubRulePolicy < ApplicationPolicy
  def index?
    staff? || sub_master?(record)
  end

  alias new? index?
  alias create? index?
  alias edit? index?
  alias update? index?
  alias confirm? index?
  alias destroy? index?
end
