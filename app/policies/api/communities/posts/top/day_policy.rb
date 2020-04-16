class Api::Communities::Posts::Top::DayPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
