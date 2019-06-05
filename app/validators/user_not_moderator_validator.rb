# frozen_string_literal: true

class UserNotModeratorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.sub.moderators.joins(:user).where("lower(users.username) = ?", value.downcase).exists?
      record.errors.add(attribute, :user_moderator)
    end
  end
end
