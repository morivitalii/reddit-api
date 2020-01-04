class Api::Users::Posts::Hot::MonthPolicy < ApplicationPolicy
  def index?
    true
  end
end
