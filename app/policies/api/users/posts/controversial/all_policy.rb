class Api::Users::Posts::Controversial::AllPolicy < ApplicationPolicy
  def index?
    true
  end
end
