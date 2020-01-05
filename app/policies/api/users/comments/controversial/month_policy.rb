class Api::Users::Comments::Controversial::MonthPolicy < ApplicationPolicy
  def index?
    true
  end
end
