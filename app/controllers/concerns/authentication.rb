# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    private

    helper_method :current_user
    def current_user
      request.env["warden"].user
    end

    helper_method :user_signed_in?
    def user_signed_in?
      current_user.present?
    end

    helper_method :user_signed_out?
    def user_signed_out?
      current_user.blank?
    end
  end
end
