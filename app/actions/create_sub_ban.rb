# frozen_string_literal: true

class CreateSubBan
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :username, :reason, :days, :permanent
  attr_reader :ban

  validates :username, presence: true, username_format: true

  with_options if: ->(record) { record.errors.blank? } do
    validates :username, username_existence: true
    validates :username, user_not_banned: true
    validates :username, user_not_moderator: true
    validates :username, user_not_staff: true
  end

  def save!
    validate!

    @user = User.where("lower(username) = ?", @username.downcase).take!

    @ban = @sub.bans.create!(
      banned_by: @current_user,
      user: @user,
      reason: @reason,
      days: @days,
      permanent: @permanent
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  else
    CreateLogJob.perform_later(
      sub: @sub,
      current_user: @current_user,
      action: "create_sub_ban",
      loggable: @user,
      model: @ban
    )
  end

  def permanent=(value)
    @permanent = ActiveModel::Type::Boolean.new.cast(value)
  end
end
