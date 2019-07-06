# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    before_action do
      Current.user = request.env["warden"].user
    end

    private

    helper_method :current_user

    def current_user
      Current.user
    end
  end
end
