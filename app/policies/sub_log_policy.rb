# frozen_string_literal: true

class SubLogPolicy < ApplicationPolicy
  def index?
    staff? || sub_moderator?(record)
  end
end
