# frozen_string_literal: true

class User::Vote::Down::CommentPolicy < ApplicationPolicy
  def index?
    # record here is user object
    user? && user.id == record.id
  end
end
