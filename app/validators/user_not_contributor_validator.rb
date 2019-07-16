# frozen_string_literal: true

class UserNotContributorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if Contributor.where(sub: record.sub).or(Contributor.where(sub: nil)).joins(:user).where("lower(users.username) = ?", value.downcase).exists?
      record.errors.add(attribute, :user_contributor)
    end
  end
end
