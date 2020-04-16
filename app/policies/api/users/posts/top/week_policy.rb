class Api::Users::Posts::Top::WeekPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
