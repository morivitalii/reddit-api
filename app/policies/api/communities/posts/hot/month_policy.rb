class Api::Communities::Posts::Hot::MonthPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
