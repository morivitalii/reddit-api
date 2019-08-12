# frozen_string_literal: true

class CreateBanForm
  include ActiveModel::Model

  attr_accessor :banned_by, :sub, :username, :reason, :days, :permanent
  attr_reader :ban

  validates :username,
            username_format: true,
            username_existence: true,
            user_not_banned: true,
            user_not_moderator: true

  def save
    return false if invalid?

    user = UsersQuery.new.with_username(username).take!

    @ban = Ban.create!(
      sub: sub,
      banned_by: banned_by,
      user: user,
      reason: reason,
      days: days,
      permanent: permanent
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
