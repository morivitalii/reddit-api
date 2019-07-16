# frozen_string_literal: true

class ContributorPolicy < ApplicationPolicy
  def index?
    true
  end

  alias search? index?

  def create?
    global_moderator? || (record.present? ? sub_moderator?(record) : false)
  end

  alias new? create?
  alias confirm? create?
  alias destroy? create?
end
