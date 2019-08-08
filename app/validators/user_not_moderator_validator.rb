# frozen_string_literal: true

class UserNotModeratorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    if scope(record, value).exists?
      record.errors.add(attribute, :user_moderator)
    end
  end

  private

  def scope(record, value)
    sub = sub(record)

    scope = ModeratorsQuery.new.global_or_sub(sub)
    ModeratorsQuery.new(scope).filter_by_username(value)
  end

  def sub(record)
    record.respond_to?(:sub) ? record.sub : nil
  end
end
