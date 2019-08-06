# frozen_string_literal: true

class UsernameExistenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    if scope(value).none?
      record.errors.add(attribute, :invalid_username)
    end
  end

  private

  def scope(username)
    UsersQuery.new.where_username(username)
  end
end
