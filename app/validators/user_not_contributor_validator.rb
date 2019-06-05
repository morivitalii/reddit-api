# frozen_string_literal: true

class UserNotContributorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.sub.contributors.joins(:user).where("lower(users.username) = ?", value.downcase).exists?
      record.errors.add(attribute, :user_contributor)
    end
  end
end
