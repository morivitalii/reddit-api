# frozen_string_literal: true

class RulePolicy < ApplicationPolicy
  def index?
    global_moderator? || (record.present? ? sub_moderator?(record) : false)
  end

  alias new? index?
  alias create? index?
  alias edit? index?
  alias update? index?
  alias confirm? index?
  alias destroy? index?
end
