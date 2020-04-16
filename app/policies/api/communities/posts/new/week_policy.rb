class Api::Communities::Posts::New::WeekPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
