# frozen_string_literal: true

module ApplicationHelper
  def user_signed_in?
    request.env["warden"].user.present?
  end

  def user_not_signed_in?
    !user_signed_in?
  end

  def datetime_tag(time, format)
    content_tag("span", "", class: "datetime-#{format}", data: { timestamp: time.to_i })
  end
end
