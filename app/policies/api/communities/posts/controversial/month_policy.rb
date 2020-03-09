class Api::Communities::Posts::Controversial::MonthPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
