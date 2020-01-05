class Api::Users::Comments::Hot::DayPolicy < ApplicationPolicy
  def index?
    true
  end
end
