class Api::Communities::Posts::New::AllPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
