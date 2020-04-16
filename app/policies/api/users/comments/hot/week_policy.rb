class Api::Users::Comments::Hot::WeekPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
