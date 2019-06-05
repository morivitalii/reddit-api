# frozen_string_literal: true

class UserNotStaffValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if Staff.joins(:user).where("lower(users.username) = ?", value.downcase).exists?
      record.errors.add(attribute, :user_staff)
    end
  end
end
