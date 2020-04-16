class Api::Communities::Posts::New::MonthPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
