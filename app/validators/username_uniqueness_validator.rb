# frozen_string_literal: true

class UsernameUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if UsersQuery.new.where_username(value).exists?
      record.errors.add(attribute, :username_taken)
    end
  end
end
