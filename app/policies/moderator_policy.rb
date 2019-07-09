# frozen_string_literal: true

class ModeratorPolicy < ApplicationPolicy
  def index?
    true
  end

  alias search? index?

  def create?
    global_moderator? || (record.present? ? sub_master?(record) : nil)
  end

  alias new? create?
  alias edit? create?
  alias update? create?
  alias confirm? create?
  alias destroy? create?
end
