class Api::SignUpController < ApplicationController
  before_action -> { authorize(Api::SignUpPolicy) }

  def create
    service = SignUp.new(create_params)

    if verify_recaptcha(model: service, attribute: :username) && service.call
      request.env["warden"].set_user(service.user)

      render json: UserSerializer.new(service.user)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    attributes = Api::SignUpPolicy.new(pundit_user).permitted_attributes_for_create

    params.permit(attributes)
  end

  def pundit_user
    Context.new(current_user, nil)
  end
end
