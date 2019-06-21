# frozen_string_literal: true

class SignInController < ApplicationController
  def new
    @form = SignIn.new

    if request.xhr?
      render partial: "new"
    else
      render "new", layout: "blank"
    end
  end

  def create
    @form = SignIn.new

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
