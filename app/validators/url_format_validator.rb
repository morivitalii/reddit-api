# frozen_string_literal: true

class UrlFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    unless valid?(value)
      record.errors.add(attr, :invalid)
    end
  rescue StandardError
    record.errors.add(attr, :invalid)
  end

  private

  def valid?(url)
    uri = uri(url)
    uri.present? && uri.host.present? && uri.scheme.in?(%w(http https))
  end

  def uri(url)
    @_uri = Addressable::URI.parse(url).normalize
  end
end