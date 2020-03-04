class Api::ForgotPasswordController < ApplicationController
  before_action -> { authorize(Api::ForgotPasswordPolicy) }

  def create
    service = ForgotPassword.new(create_params)

    if verify_recaptcha(model: service, attribute: :email) && service.call
      head :no_content
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    attributes = Api::ForgotPasswordPolicy.new(pundit_user).permitted_attributes_for_create

    params.permit(attributes)
  end

  def pundit_user
    Context.new(current_user, nil)
  end
end
