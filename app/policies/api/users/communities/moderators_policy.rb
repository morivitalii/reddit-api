class Api::Users::Communities::ModeratorsPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
