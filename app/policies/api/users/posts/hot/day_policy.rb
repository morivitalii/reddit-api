class Api::Users::Posts::Hot::DayPolicy < ApplicationPolicy
  def index?
    true
  end
end
