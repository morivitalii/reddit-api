class Api::Communities::Posts::Controversial::AllPolicy < ApplicationPolicy
  def index?
    true
  end
end
