class Api::Users::Posts::Controversial::WeekPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
