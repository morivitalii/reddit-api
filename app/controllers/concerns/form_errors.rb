# frozen_string_literal: true

module FormErrors
  extend ActiveSupport::Concern

  included do
    private

    rescue_from "ActiveModel::ValidationError", with: :form_errors_response

    def form_errors_response
      render json: @form.errors, status: :unprocessable_entity
    end
  end
end
