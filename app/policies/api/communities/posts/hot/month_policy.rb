class Api::Communities::Posts::Hot::MonthPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
