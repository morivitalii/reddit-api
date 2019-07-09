# frozen_string_literal: true

class LogPolicy < ApplicationPolicy
  def index?
    global_moderator? || (record.present? ? sub_moderator?(record) : false)
  end
end
