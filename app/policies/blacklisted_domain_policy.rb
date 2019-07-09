# frozen_string_literal: true

class BlacklistedDomainPolicy < ApplicationPolicy
  def index?
    global_moderator? || (record.present? ? sub_moderator?(record) : false)
  end

  alias search? index?
  alias new? index?
  alias create? index?
  alias confirm? index?
  alias destroy? index?
end
