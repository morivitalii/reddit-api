class Api::Users::Posts::Hot::AllPolicy < ApplicationPolicy
  def index?
    true
  end
end
