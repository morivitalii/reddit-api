class Api::Communities::Posts::Controversial::WeekPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
