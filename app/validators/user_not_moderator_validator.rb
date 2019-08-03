# frozen_string_literal: true

class UserNotModeratorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if scope(record.sub, value).exists?
      record.errors.add(attribute, :user_moderator)
    end
  end

  private

  def scope(sub, username)
    scope = ModeratorsQuery.new.where_global_or_sub(sub)
    ModeratorsQuery.new(scope).filter_by_username(username)
  end
end
