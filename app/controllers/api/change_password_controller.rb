class Api::ChangePasswordController < ApplicationController
  before_action -> { authorize(nil, policy_class: Api::ChangePasswordPolicy) }
  before_action :set_community

  def edit
    @form = ChangePasswordForm.new(link_params)
  end

  def update
    @form = ChangePasswordForm.new(create_params)

    if @form.save
      request.env["warden"].set_user(@form.user)

      head :no_content, location: root_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private

  def set_community
    @community = CommunitiesQuery.new.default.take!
  end

  def link_params
    params.permit(:token)
  end

  def create_params
    attributes = Api::ChangePasswordPolicy.new(pundit_user).permitted_attributes_for_update
    params.require(:change_password_form).permit(attributes)
  end

  def pundit_user
    Context.new(current_user, @community)
  end
end
