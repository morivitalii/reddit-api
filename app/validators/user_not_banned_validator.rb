# frozen_string_literal: true

class UserNotBannedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unless valid?(record, value)
      record.errors.add(attribute, :user_banned)
    end
  end

  private

  def valid?(record, value)
    BansQuery.new(record.community.bans).with_username(value).none?
  end
end
