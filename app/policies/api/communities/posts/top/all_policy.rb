class Api::Communities::Posts::Top::AllPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
