# frozen_string_literal: true

class SubDeletionReasonPolicy < ApplicationPolicy
  def index?
    staff? || sub_master?(record)
  end

  alias create? index?
  alias update? index?
  alias destroy? index?
end
