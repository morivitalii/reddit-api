# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def create?
    user_signed_in? && !context.user.banned?(record.sub)
  end

  def update?
    user_signed_in? && !context.user.banned?(record.sub) && record.user_id == context.user.id
  end

  alias new? create?
  alias edit? update?
end
