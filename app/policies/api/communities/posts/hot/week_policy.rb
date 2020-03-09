class Api::Communities::Posts::Hot::WeekPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
