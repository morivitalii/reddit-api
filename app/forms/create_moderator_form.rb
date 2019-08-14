# frozen_string_literal: true

class CreateModeratorForm
  include ActiveModel::Model

  attr_accessor :sub, :username
  attr_reader :moderator

  validates :username,
            username_format: true,
            username_existence: true,
            user_not_banned: true,
            user_not_moderator: true

  def save
    return false if invalid?

    user = UsersQuery.new.with_username(username).take!

    @moderator = Moderator.create!(
      sub: sub,
      user: user
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
