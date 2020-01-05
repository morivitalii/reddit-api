class Api::Users::Comments::Controversial::DayPolicy < ApplicationPolicy
  def index?
    true
  end
end
