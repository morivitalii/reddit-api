# frozen_string_literal: true

class SubsPolicy < ApplicationPolicy
  def update?(sub)
    staff? || master?(sub)
  end
end
