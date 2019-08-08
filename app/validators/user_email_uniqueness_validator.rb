# frozen_string_literal: true

class UserEmailUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    if scope(value).exists?
      record.errors.add(attribute, :email_taken)
    end
  end

  private

  def scope(username)
    UsersQuery.new.where_email(username)
  end
end
