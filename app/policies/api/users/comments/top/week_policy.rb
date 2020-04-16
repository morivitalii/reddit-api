class Api::Users::Comments::Top::WeekPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
