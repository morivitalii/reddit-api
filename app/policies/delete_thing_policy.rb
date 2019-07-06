# frozen_string_literal: true

class DeleteThingPolicy < ApplicationPolicy
  def create?
    return false unless user?

    staff? || moderator?(record.sub) || record.user_id == user.id
  end

  alias new? create?
end
