# frozen_string_literal: true

class DeletionReasonPolicy < ApplicationPolicy
  def index?
    staff?
  end

  alias new? index?
  alias create? index?
  alias edit? index?
  alias update? index?
  alias confirm? index?
  alias destroy? index?
end
