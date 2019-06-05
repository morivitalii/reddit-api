# frozen_string_literal: true

module SetVariant
  extend ActiveSupport::Concern

  included do
    before_action do
      request.variant = browser.device.mobile? ? :mobile : :desktop
      Current.variant = request.variant
    end
  end
end
