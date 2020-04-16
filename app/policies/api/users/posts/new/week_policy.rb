class Api::Users::Posts::New::WeekPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
