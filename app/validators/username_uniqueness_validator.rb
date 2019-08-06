# frozen_string_literal: true

class UsernameUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    if scope(value).exists?
      record.errors.add(attribute, :username_taken)
    end
  end

  private

  def scope(username)
    UsersQuery.new.where_username(username)
  end
end
