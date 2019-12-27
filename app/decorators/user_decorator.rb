class UserDecorator < ApplicationDecorator
  def created_at
    model.created_at
  end
end
