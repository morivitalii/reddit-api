# frozen_string_literal: true

class EmailUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if UsersQuery.new.where_email(value).exists?
      record.errors.add(attribute, :email_taken)
    end
  end
end
