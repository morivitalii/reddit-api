# frozen_string_literal: true

class DeleteThingPolicy < ApplicationPolicy
  def create?
    user_signed_in? && (record.user_id == context.user.id || context.user.moderator?(record.sub))
  end

  alias new? create?
end
