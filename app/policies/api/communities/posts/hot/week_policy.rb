class Api::Communities::Posts::Hot::WeekPolicy < ApplicationPolicy
  def index?
    true
  end
end
