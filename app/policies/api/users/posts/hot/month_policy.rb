class Api::Users::Posts::Hot::MonthPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
