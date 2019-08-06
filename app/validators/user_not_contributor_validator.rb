# frozen_string_literal: true

class UserNotContributorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    if scope(record.sub, value).exists?
      record.errors.add(attribute, :user_contributor)
    end
  end

  private

  def scope(sub, username)
    scope = ContributorsQuery.new.global_or_sub(sub)
    ContributorsQuery.new(scope).filter_by_username(username)
  end
end
