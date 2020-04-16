class Api::Communities::Posts::New::DayPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
