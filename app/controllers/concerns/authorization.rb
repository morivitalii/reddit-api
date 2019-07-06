# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    before_action do
      Current.user = request.env["warden"].user
    end

    private

    helper_method :current_user

    def current_user
      Current.user
    end

    rescue_from "ApplicationPolicy::AuthorizationError", with: :authorization_error_response

    def authorization_error_response
      if helpers.user_signed_in?
        if request.xhr?
          head :not_acceptable
        else
          render "/authorization_error", status: :not_acceptable, layout: "blank"
        end
      else
        @form = SignIn.new

        if request.xhr?
          render partial: "sign_in/new", status: :unauthorized
        else
          render "sign_in/new", status: :unauthorized, layout: "blank"
        end
      end
    end
  end
end
