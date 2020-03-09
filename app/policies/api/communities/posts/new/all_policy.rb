class Api::Communities::Posts::New::AllPolicy < ApplicationPolicy
  def index?
    !banned?
  end
end
