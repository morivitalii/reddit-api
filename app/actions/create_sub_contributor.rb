# frozen_string_literal: true

class CreateSubContributor
  include ActiveModel::Model

  attr_accessor :sub, :current_user, :username
  attr_reader :contributor

  validates :username, presence: true, username_format: true

  with_options if: ->(r) { r.errors.blank? } do
    validates :username, username_existence: true
    validates :username, user_not_banned: true
    validates :username, user_not_moderator: true
    validates :username, user_not_contributor: true
  end

  def save
    return false if invalid?

    @user = User.where("lower(username) = ?", @username.downcase).take!

    @contributor = @sub.contributors.create!(
      approved_by: @current_user,
      user: @user
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  else
    CreateLogJob.perform_later(
      sub: @sub,
      current_user: @current_user,
      action: "create_sub_contributor",
      loggable: @user
    )
  end
end
