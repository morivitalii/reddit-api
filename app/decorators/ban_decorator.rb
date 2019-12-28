class BanDecorator < ApplicationDecorator
  def username
    model.user.username
  end
end
