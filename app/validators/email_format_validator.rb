# frozen_string_literal: true

class EmailFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless valid?(value)
      record.errors.add(attribute, :invalid)
    end
  end

  private

  def valid?(value)
    /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,64})\z/i.match?(value)
  end
end
