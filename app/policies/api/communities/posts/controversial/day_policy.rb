class Api::Communities::Posts::Controversial::DayPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
