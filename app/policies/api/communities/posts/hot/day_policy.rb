class Api::Communities::Posts::Hot::DayPolicy < ApplicationPolicy
  def index?
    true
  end
end
