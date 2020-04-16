class Api::Users::Comments::Hot::AllPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
