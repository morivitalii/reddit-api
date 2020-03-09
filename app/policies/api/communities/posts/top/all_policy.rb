class Api::Communities::Posts::Top::AllPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
