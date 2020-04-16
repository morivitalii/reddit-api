class Api::Communities::Posts::Controversial::AllPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
