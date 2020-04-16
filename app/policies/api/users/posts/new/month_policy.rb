class Api::Users::Posts::New::MonthPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
