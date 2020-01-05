class Api::Users::Comments::Hot::AllPolicy < ApplicationPolicy
  def index?
    true
  end
end
