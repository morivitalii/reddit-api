# frozen_string_literal: true

module StripAttributes
  extend ActiveSupport::Concern

  included do
    def self.strip_attributes(*attributes, squish: false)
      attributes.each do |attribute|
        define_method(:"#{attribute}=") do |value|
          if value.blank?
            super(nil)
          elsif squish
            super(value.squish)
          else
            super(value.strip)
          end
        end
      end
    end
  end
end