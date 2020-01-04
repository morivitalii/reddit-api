class Api::Users::Posts::Top::WeekPolicy < ApplicationPolicy
  def index?
    true
  end
end
