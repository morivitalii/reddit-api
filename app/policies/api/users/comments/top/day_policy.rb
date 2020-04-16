class Api::Users::Comments::Top::DayPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
