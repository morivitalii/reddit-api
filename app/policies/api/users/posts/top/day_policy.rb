class Api::Users::Posts::Top::DayPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
