class Api::Users::Comments::Controversial::AllPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
