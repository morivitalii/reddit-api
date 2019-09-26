# frozen_string_literal: true

class ModeratorDecorator < ApplicationDecorator
  def username
    model.user.username
  end
end
