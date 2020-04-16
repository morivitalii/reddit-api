class Api::Users::Posts::Hot::DayPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
