class Api::Communities::Posts::Controversial::MonthPolicy < ApplicationPolicy
  def index?
    true
  end
end
