class Api::Communities::Posts::New::WeekPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
