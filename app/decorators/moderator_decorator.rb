class ModeratorDecorator < ApplicationDecorator
  def username
    model.user.username
  end
end
