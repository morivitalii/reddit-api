class Api::Communities::Posts::Controversial::MonthPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
