class Api::ForgotPasswordController < ApplicationController
  before_action -> { authorize(nil, policy_class: Api::ForgotPasswordPolicy) }

  def new
    @form = ForgotPasswordForm.new

    render partial: "new"
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

  def create_params
    attributes = Api::ForgotPasswordPolicy.new(pundit_user, nil).permitted_attributes_for_create
    params.require(:forgot_password_form).permit(attributes)
  end

  def pundit_user
    Context.new(current_user, nil)
  end
end
