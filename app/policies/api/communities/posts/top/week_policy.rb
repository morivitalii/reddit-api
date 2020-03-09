class Api::Communities::Posts::Top::WeekPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
