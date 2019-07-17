# frozen_string_literal: true

class TagPolicy < ApplicationPolicy
  def index?
    global_moderator? || sub_moderator?(record)
  end

  alias new? index?
  alias create? index?
  alias edit? index?
  alias update? index?
  alias confirm? index?
  alias destroy? index?
end
