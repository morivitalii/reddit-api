class Api::Users::Comments::New::DayPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
