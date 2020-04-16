class Api::Users::Comments::Controversial::WeekPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
