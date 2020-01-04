class Api::Users::Posts::Controversial::MonthPolicy < ApplicationPolicy
  def index?
    true
  end
end
