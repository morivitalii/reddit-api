class Api::Users::Posts::New::DayPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
