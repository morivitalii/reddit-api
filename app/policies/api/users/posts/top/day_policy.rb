class Api::Users::Posts::Top::DayPolicy < ApplicationPolicy
  def index?
    true
  end
end
