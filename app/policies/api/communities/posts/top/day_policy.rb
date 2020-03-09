class Api::Communities::Posts::Top::DayPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
