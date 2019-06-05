# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def new?
    # TODO return false if global_banned?
    user?
  end
end
