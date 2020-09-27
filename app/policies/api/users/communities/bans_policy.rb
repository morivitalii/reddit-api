class Api::Users::Communities::BansPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
