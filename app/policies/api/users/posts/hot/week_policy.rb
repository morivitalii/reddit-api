class Api::Users::Posts::Hot::WeekPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
