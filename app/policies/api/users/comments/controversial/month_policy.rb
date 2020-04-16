class Api::Users::Comments::Controversial::MonthPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
