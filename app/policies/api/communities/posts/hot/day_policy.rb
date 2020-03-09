class Api::Communities::Posts::Hot::DayPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
