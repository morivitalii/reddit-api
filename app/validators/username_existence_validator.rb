# frozen_string_literal: true

class UsernameExistenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unless valid?(value)
      record.errors.add(attribute, :invalid_username)
    end
  end

  private

  def valid?(value)
    UsersQuery.new.with_username(value).exists?
  end
end
