# frozen_string_literal: true

class UsernameFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless /\A[a-z0-9_-]{2,16}\z/i.match?(value)
      record.errors.add(attribute, :invalid_username_format)
    end
  end
end
