# frozen_string_literal: true

class CreateBan
  include ActiveModel::Model

  attr_accessor :current_user, :sub, :username, :reason, :days, :permanent
  attr_reader :ban

  validates :username, presence: true, username_format: true

  with_options if: ->(record) { record.errors.blank? } do
    validates :username, username_existence: true
    validates :username, user_not_banned: true
    validates :username, user_not_staff: true
  end

  validates :username, user_not_moderator: true, if: ->(record) { record.sub.present? && record.errors.blank? }

  def save
    return false if invalid?

    @user = User.where("lower(username) = ?", @username.downcase).take!

    @ban = Ban.create!(
      sub: @sub,
      banned_by: @current_user,
      user: @user,
      reason: @reason,
      days: @days,
      permanent: @permanent
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  else
    CreateLogJob.perform_later(
      sub: @sub,
      current_user: @current_user,
      action: "create_ban",
      loggable: @user,
      model: @ban
    )
  end

  def permanent=(value)
    @permanent = ActiveModel::Type::Boolean.new.cast(value)
  end
end
