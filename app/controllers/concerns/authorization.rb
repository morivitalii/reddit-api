# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    before_action do
      Current.user = request.env["warden"].user
    end
  end
end
