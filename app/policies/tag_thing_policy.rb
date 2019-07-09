# frozen_string_literal: true

class TagThingPolicy < ApplicationPolicy
  def update?
    record.post? && (global_moderator? || sub_moderator?(record.sub))
  end

  alias edit? update?
end
