class Api::Communities::Posts::Hot::MonthPolicy < ApplicationPolicy
  def index?
    true
  end
end
