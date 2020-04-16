class Api::Users::Comments::Controversial::DayPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
