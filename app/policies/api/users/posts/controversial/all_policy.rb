class Api::Users::Posts::Controversial::AllPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
