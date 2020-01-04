class Api::Users::Posts::Hot::WeekPolicy < ApplicationPolicy
  def index?
    true
  end
end
