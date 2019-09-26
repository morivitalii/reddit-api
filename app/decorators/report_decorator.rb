# frozen_string_literal: true

class ReportDecorator < ApplicationDecorator
  def username
    model.user.username
  end

  def created_at
    h.datetime_ago_tag(model.created_at)
  end
end
