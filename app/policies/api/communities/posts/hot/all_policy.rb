class Api::Communities::Posts::Hot::AllPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
