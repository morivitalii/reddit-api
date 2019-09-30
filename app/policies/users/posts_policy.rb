# frozen_string_literal: true

class Users::PostsPolicy < ApplicationPolicy
  def index?
    true
  end
end