class Api::UsersController < ApplicationController
  before_action -> { authorize(Api::UsersPolicy, @user) }

  def update
    service = UpdateUser.new(update_params)

    if service.call
      render json: UserSerializer.serialize(service.user)
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  private

  def update_params
    attributes = Api::UsersPolicy.new(pundit_user, current_user).permitted_attributes_for_update

    params.permit(attributes).merge(user: current_user)
  end
end
