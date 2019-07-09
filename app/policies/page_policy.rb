# frozen_string_literal: true

class PagePolicy < ApplicationPolicy
  def index?
    global_moderator? || (record.present? ? sub_moderator?(record) : false)
  end

  def show?
    true
  end

  alias new? index?
  alias create? index?
  alias edit? index?
  alias update? index?
  alias confirm? index?
  alias destroy? index?
end
