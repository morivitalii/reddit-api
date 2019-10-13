# frozen_string_literal: true

class User::Bookmark::PostPolicy < ApplicationPolicy
  def index?
    # record here is user object
    user? && user.id == record.id
  end
end
