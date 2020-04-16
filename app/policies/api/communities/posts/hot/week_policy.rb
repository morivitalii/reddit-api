class Api::Communities::Posts::Hot::WeekPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
