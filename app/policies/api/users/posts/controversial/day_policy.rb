class Api::Users::Posts::Controversial::DayPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
