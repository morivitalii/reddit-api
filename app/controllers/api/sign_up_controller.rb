class Api::SignUpController < ApplicationController
  before_action -> { authorize(nil, policy_class: Api::SignUpPolicy) }

  def new
    @form = SignUpForm.new

    render partial: "new"
  end

  def create
    @form = SignUpForm.new(create_params)

    if verify_recaptcha(model: @form, attribute: :username) && @form.save
      request.env["warden"].set_user(@form.user)

      head :no_content, location: root_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    attributes = Api::SignUpPolicy.new(pundit_user, nil).permitted_attributes_for_create
    params.require(:sign_up_form).permit(attributes)
  end

  def pundit_user
    Context.new(current_user, nil)
  end
end
