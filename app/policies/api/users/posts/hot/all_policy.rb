class Api::Users::Posts::Hot::AllPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
