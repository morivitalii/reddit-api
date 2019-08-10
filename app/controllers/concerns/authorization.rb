# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    helper_method :current_user

    def current_user
      request.env["warden"].user
    end

    def pundit_user
      context
    end

    rescue_from "Pundit::NotAuthorizedError", with: :authorization_error_response

    def authorization_error_response
      if helpers.user_signed_in?
        if request.xhr?
          head :not_acceptable
        else
          render "/authorization_error", status: :not_acceptable
        end
      else
        @form = SignInForm.new

        if request.xhr?
          render partial: "sign_in/new", status: :unauthorized
        else
          render "sign_in/new", status: :unauthorized
        end
      end
    end
  end
end
