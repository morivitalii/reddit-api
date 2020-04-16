class Api::Users::Comments::Hot::DayPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
