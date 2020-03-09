class Api::Communities::Posts::Hot::AllPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
