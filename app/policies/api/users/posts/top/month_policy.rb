class Api::Users::Posts::Top::MonthPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
