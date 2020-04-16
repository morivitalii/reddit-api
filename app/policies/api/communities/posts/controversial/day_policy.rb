class Api::Communities::Posts::Controversial::DayPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
