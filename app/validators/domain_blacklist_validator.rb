# frozen_string_literal: true

class DomainBlacklistValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    unless valid?(record, value)
      record.errors.add(attr, :blacklisted_domain)
    end
  rescue StandardError
    record.errors.add(attr, :invalid)
  end

  private

  def valid?(record, value)
    scope(record, value).none?
  end

  def scope(record, value)
    domain = domain(value)
    sub = sub(record)

    scope = BlacklistedDomainsQuery.new.global_or_sub(sub)
    BlacklistedDomainsQuery.new(scope).filter_by_domain(domain)
  end

  def sub(record)
    record.respond_to?(:sub) ? record.sub : nil
  end

  def domain(value)
    uri(value).host.split(".").last(2).join(".")
  end

  def uri(value)
    @_uri = Addressable::URI.parse(value).normalize
  end
end