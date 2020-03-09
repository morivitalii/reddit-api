class Api::Communities::Posts::Controversial::AllPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
