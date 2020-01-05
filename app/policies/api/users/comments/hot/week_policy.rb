class Api::Users::Comments::Hot::WeekPolicy < ApplicationPolicy
  def index?
    true
  end
end
