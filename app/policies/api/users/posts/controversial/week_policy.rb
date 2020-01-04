class Api::Users::Posts::Controversial::WeekPolicy < ApplicationPolicy
  def index?
    true
  end
end
