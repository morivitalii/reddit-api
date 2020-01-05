class Api::Users::Comments::Controversial::WeekPolicy < ApplicationPolicy
  def index?
    true
  end
end
