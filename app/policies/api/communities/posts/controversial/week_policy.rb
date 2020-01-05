class Api::Communities::Posts::Controversial::WeekPolicy < ApplicationPolicy
  def index?
    true
  end
end
