# frozen_string_literal: true

module Authorization
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

    def pundit_user
      Context.new(current_user)
    end

    rescue_from Pundit::NotAuthorizedError, with: :authorization_error

    def authorization_error
      if request.xhr?
        head :forbidden
      else
        @community = CommunitiesQuery.new.default.take!

        render "/authorization_error", status: :forbidden
      end
    end
  end
end
