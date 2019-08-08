# frozen_string_literal: true

class UserNotContributorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    if scope(record, value).exists?
      record.errors.add(attribute, :user_contributor)
    end
  end

  private

  def scope(record, username)
    sub = sub(record)

    scope = ContributorsQuery.new.global_or_sub(sub)
    ContributorsQuery.new(scope).filter_by_username(username)
  end

  def sub(record)
    record.respond_to?(:sub) ? record.sub : nil
  end
end
