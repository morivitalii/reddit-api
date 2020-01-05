class Api::Users::Comments::Hot::MonthPolicy < ApplicationPolicy
  def index?
    true
  end
end
