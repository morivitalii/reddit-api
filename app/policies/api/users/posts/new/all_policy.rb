class Api::Users::Posts::New::AllPolicy < ApplicationPolicy
  def index?
    !exiled?
  end
end
