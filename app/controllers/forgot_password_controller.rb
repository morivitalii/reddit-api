# frozen_string_literal: true

class ForgotPasswordController < ApplicationController
  def new
    @form = ForgotPassword.new

    if request.xhr?
      render partial: "new"
    else
      render "new", layout: "blank"
    end
  end

  def create
    @form = ForgotPassword.new(create_params)

    if verify_recaptcha(model: @form, attribute: :email) && @form.save
      head :no_content
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:forgot_password).permit(:email)
  end
end
