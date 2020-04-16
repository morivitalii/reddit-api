class Api::Users::Comments::Top::AllPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
