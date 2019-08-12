# frozen_string_literal: true

class DomainBlacklistValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless valid?(record, value)
      record.errors.add(attribute, :blacklisted_domain)
    end
  end

  private

  def valid?(record, value)
    BlacklistedDomainsQuery.new(record.sub.blacklisted_domains).with_domain(value).none?
  end
end