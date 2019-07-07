# frozen_string_literal: true

class UserNotBannedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if Ban.joins(:user).where(sub: record.sub).where("lower(users.username) = ?", value.downcase).exists?
      record.errors.add(attribute, :user_banned)
    end
  end
end
