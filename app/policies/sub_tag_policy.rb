# frozen_string_literal: true

class SubTagPolicy < ApplicationPolicy
  def index?
    global_moderator? || sub_master?(record)
  end

  alias new? index?
  alias create? index?
  alias edit? index?
  alias update? index?
  alias confirm? index?
  alias destroy? index?
end
