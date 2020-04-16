class Api::Communities::Posts::Top::MonthPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
