# frozen_string_literal: true

class CreateContributorForm
  include ActiveModel::Model

  attr_accessor :sub, :approved_by, :username
  attr_reader :contributor

  validates :username,
            username_format: true,
            username_existence: true,
            user_not_banned: true,
            user_not_moderator: true,
            user_not_contributor: true

  def save
    return false if invalid?

    user = UsersQuery.new.with_username(username).take!

    @contributor = Contributor.create!(
      sub: sub,
      approved_by: approved_by,
      user: user
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
