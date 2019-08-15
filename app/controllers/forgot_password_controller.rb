# frozen_string_literal: true

class ForgotPasswordController < ApplicationController
  before_action -> { authorize(:forgot_password) }
  before_action :set_facade

  def new
    @form = ForgotPasswordForm.new

    if request.xhr?
      render partial: "new"
    else
      render "new"
    end
  end

  def create
    @form = ForgotPasswordForm.new(create_params)

    if verify_recaptcha(model: @form, attribute: :email) && @form.save
      head :no_content
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def context
    Context.new(current_user, CommunitiesQuery.new.default.take!)
  end

  def set_facade
    @facade = ApplicationFacade.new(context)
  end

  def create_params
    attributes = policy(:forgot_password).permitted_attributes_for_create

    params.require(:forgot_password_form).permit(attributes)
  end
end
