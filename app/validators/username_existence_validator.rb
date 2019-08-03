# frozen_string_literal: true

class UsernameExistenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if UsersQuery.new.where_username(value).none?
      record.errors.add(attribute, :invalid_username)
    end
  end
end
