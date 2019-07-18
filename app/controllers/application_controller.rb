# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SetVariant
  include PageNotFound
  include Authorization
  include Navigation
  include Pundit

  private

  def pundit_user
    UserContext.new(current_user, nil)
  end

  rescue_from "Pundit::NotAuthorizedError", with: :authorization_error_response

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
