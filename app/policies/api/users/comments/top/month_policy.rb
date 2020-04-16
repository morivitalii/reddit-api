class Api::Users::Comments::Top::MonthPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
