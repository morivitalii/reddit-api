# frozen_string_literal: true

class SubTagsPolicy < ApplicationPolicy
  def index?(sub)
    staff? || sub_master?(sub)
  end

  alias create? index?
  alias update? index?
  alias destroy? index?
end
