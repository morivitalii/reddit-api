# frozen_string_literal: true

class UserNotBannedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    if scope(record, value).exists?
      record.errors.add(attribute, :user_banned)
    end
  end

  private

  def scope(record, username)
    sub = sub(record)

    scope = BansQuery.new.global_or_sub(sub)
    BansQuery.new(scope).filter_by_username(username)
  end

  def sub(record)
    record.respond_to?(:sub) ? record.sub : nil
  end
end
