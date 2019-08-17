# frozen_string_literal: true

module ApplicationHelper
  def user_signed_in?
    request.env["warden"].user.present?
  end

  def user_not_signed_in?
    !user_signed_in?
  end
end
