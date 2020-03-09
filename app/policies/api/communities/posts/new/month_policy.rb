class Api::Communities::Posts::New::MonthPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
