class Api::Communities::Posts::Top::WeekPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
