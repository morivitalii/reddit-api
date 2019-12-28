class ReportDecorator < ApplicationDecorator
  def username
    model.user.username
  end
end
