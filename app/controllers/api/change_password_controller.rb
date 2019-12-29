class Api::ChangePasswordController < ApiApplicationController
  before_action -> { authorize(Api::ChangePasswordPolicy) }

  def update
    service = ChangePassword.new(update_params)

    if service.call
      request.env["warden"].set_user(service.user)

      render json: UserSerializer.serialize(service.user)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  private

  def update_params
    attributes = Api::ChangePasswordPolicy.new(pundit_user).permitted_attributes_for_update

    params.permit(attributes)
  end
end
