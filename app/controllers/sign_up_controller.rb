# frozen_string_literal: true

class SignUpController < ApplicationController
  before_action -> { authorize(:sign_up) }
  before_action :set_community
  decorates_assigned :community

  def new
    @form = SignUpForm.new

    if request.xhr?
      render partial: "new"
    else
      render "new"
    end
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

  def pundit_user
    Context.new(current_user, @community)
  end

  def set_community
    @community = CommunitiesQuery.new.default.take!
  end

  def create_params
    attributes = policy(:sign_up).permitted_attributes_for_create

    params.require(:sign_up_form).permit(attributes)
  end
end
