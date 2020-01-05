class Api::Communities::Posts::Controversial::DayPolicy < ApplicationPolicy
  def index?
    true
  end
end
