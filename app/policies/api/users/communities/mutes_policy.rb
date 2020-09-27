class Api::Users::Communities::MutesPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
