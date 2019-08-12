# frozen_string_literal: true

class UsernameUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unless valid?(value)
      record.errors.add(attribute, :username_taken)
    end
  end

  private

  def valid?(value)
    UsersQuery.new.with_username(value).none?
  end
end
