# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  def created_at
    h.datetime_short_tag(model.created_at)
  end
end