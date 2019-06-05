# frozen_string_literal: true

class UsernameExistenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if User.where("lower(username) = ?", value.downcase).none?
      record.errors.add(attribute, :invalid_username)
    end
  end
end
