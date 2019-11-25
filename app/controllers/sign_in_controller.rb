class SignInController < ApplicationController
  before_action -> { authorize(:sign_in) }

  def new
    @form = SignInForm.new

    render partial: "new"
  end

  def create
    @form = SignInForm.new

    if verify_recaptcha(model: @form, attribute: :username) && request.env["warden"].authenticate!(:password)
      head :no_content, location: root_path
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def unauthenticated
    @form = request.env["warden.options"][:form]

    render json: @form.errors, status: :unprocessable_entity
  end

  private

  def pundit_user
    Context.new(current_user, nil)
  end
end
