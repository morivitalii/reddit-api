# frozen_string_literal: true

class UserNotContributorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unless valid?(record, value)
      record.errors.add(attribute, :user_contributor)
    end
  end

  private

  def valid?(record, value)
    ContributorsQuery.new(record.sub.contributors).with_username(value).none?
  end
end
