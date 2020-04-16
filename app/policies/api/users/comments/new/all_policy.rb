class Api::Users::Comments::New::AllPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
