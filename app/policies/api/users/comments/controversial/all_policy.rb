class Api::Users::Comments::Controversial::AllPolicy < ApplicationPolicy
  def index?
    true
  end
end
