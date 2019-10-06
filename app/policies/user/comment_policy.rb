# frozen_string_literal: true

class User::CommentPolicy < ApplicationPolicy
  def index?
    true
  end
end