class Api::Users::Posts::Controversial::DayPolicy < ApplicationPolicy
  def index?
    true
  end
end
