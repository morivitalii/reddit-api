class Api::Users::Posts::Controversial::MonthPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
