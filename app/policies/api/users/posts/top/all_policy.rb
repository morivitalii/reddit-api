class Api::Users::Posts::Top::AllPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
