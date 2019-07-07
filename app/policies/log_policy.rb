# frozen_string_literal: true

class LogPolicy < ApplicationPolicy
  def index?
    staff? || (record.present? ? sub_moderator?(record) : false)
  end
end
