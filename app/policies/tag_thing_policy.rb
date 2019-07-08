# frozen_string_literal: true

class TagThingPolicy < ApplicationPolicy
  def update?
    record.post? && (staff? || sub_moderator?(record.sub))
  end

  alias edit? update?
end
