class Api::Users::Comments::New::MonthPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
