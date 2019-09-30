# frozen_string_literal: true

class Users::CommentsPolicy < ApplicationPolicy
  def index?
    true
  end
end