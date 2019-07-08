# frozen_string_literal: true

class PagePolicy < ApplicationPolicy
  def index?
    staff? || (record.present? ? sub_moderator?(sub) : false)
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
