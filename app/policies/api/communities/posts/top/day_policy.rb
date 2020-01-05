class Api::Communities::Posts::Top::DayPolicy < ApplicationPolicy
  def index?
    true
  end
end
