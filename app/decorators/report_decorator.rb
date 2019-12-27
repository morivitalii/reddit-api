class ReportDecorator < ApplicationDecorator
  def username
    model.user.username
  end

  def created_at
    model.created_at
  end
end
