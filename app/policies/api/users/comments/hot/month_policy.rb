class Api::Users::Comments::Hot::MonthPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
