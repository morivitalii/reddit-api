# frozen_string_literal: true

class UrlFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless valid?(value)
      record.errors.add(attribute, :invalid)
    end
  rescue StandardError
    record.errors.add(attribute, :invalid)
  end

  private

  def valid?(value)
    uri = Addressable::URI.parse(value).normalize
    uri.present? && uri.host.present? && uri.scheme.in?(%w(http https))
  end
end