class Api::Communities::Posts::Top::MonthPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
