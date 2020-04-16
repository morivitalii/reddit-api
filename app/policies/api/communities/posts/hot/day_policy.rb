class Api::Communities::Posts::Hot::DayPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
