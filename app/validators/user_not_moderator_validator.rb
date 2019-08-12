# frozen_string_literal: true

class UserNotModeratorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unless valid?(record, value)
      record.errors.add(attribute, :user_moderator)
    end
  end

  private

  def valid?(record, value)
    ModeratorsQuery.new(record.sub.moderators).with_username(value).none?
  end
end
