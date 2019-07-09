# frozen_string_literal: true

class UserNotModeratorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if Moderator.where(sub: record.sub).or(Moderator.where(sub: nil)).joins(:user).where("lower(users.username) = ?", value.downcase).exists?
      record.errors.add(attribute, :user_moderator)
    end
  end
end
