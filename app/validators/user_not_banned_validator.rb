# frozen_string_literal: true

class UserNotBannedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if Ban.where(sub: record.sub).or(Ban.where(sub: nil)).joins(:user).where("lower(users.username) = ?", value.downcase).exists?
      record.errors.add(attribute, :user_banned)
    end
  end
end
