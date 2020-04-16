class Api::Communities::Posts::Controversial::WeekPolicy < ApplicationPolicy
  def index?
    !exiled? && !banned?
  end
end
