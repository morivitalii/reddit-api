# frozen_string_literal: true

class User::PostPolicy < ApplicationPolicy
  def index?
    true
  end
end
