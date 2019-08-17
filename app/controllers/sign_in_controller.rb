# frozen_string_literal: true

class SignInController < ApplicationController
  before_action :set_facade
  before_action -> { authorize(:sign_in) }, only: [:new, :create]
  skip_after_action :verify_authorized, only: [:unauthenticated]

  def new
    @form = SignInForm.new

    if request.xhr?
      render partial: "new"
    else
      render "new"
    end
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
end
