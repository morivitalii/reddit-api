# frozen_string_literal: true

class SignUpController < ApplicationController
  before_action -> { authorize(:sign_up) }

  def new
    @form = SignUp.new

    if request.xhr?
      render partial: "new"
    else
      render "new"
    end
  end

  def create
    @form = SignUp.new(create_params)

    if verify_recaptcha(model: @form, attribute: :username) && @form.save
      request.env["warden"].set_user(@form.user)

      head :no_content, location: root_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    attributes = policy(:sign_up).permitted_attributes_for_create

    params.require(:sign_up).permit(attributes)
  end
end
