# frozen_string_literal: true

class UsernameUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if User.where("lower(username) = ?", value.downcase).exists?
      record.errors.add(attribute, :username_taken)
    end
  end
end
