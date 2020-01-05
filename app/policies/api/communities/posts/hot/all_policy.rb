class Api::Communities::Posts::Hot::AllPolicy < ApplicationPolicy
  def index?
    true
  end
end
