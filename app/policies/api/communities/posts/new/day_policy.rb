class Api::Communities::Posts::New::DayPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
