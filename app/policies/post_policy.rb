# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def new?
    user?
  end
end
