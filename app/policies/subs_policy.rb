# frozen_string_literal: true

class SubsPolicy < ApplicationPolicy
  def update?(sub)
    staff? || sub_master?(sub)
  end
end
