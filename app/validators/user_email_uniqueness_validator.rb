# frozen_string_literal: true

class UserEmailUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unless valid?(value)
      record.errors.add(attribute, :email_taken)
    end
  end

  private

  def valid?(value)
    UsersQuery.new.with_email(value).none?
  end
end
