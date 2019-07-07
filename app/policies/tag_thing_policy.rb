# frozen_string_literal: true

class TagThingPolicy < ApplicationPolicy
  def update?
    staff? || sub_moderator?(record.sub)
  end

  alias edit? update?
end
