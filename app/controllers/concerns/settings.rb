# frozen_string_literal: true

module Settings
  extend ActiveSupport::Concern

  included do
    before_action do
      settings = Setting.all

      keys = settings.map(&:key)
      values = settings.map do |setting|
        if setting.value.is_a?(Hash)
          setting.value.with_indifferent_access
        elsif setting.value.is_a?(Array) || setting.value.is_a?(String)
          setting.value.inquiry
        else
          setting.value
        end
      end

      Struct.new("Settings", *keys)
      Current.settings = Struct::Settings.new(*values)
    end
  end
end
