class Api::Users::Comments::New::WeekPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
