class ApplicationPolicy
  attr_reader :user, :sub, :record

  def initialize(context, record)
    @user = context.user
    @sub = context.sub
    @record = record

    if user_signed_in? && user_banned?
      raise ApplicationPolicy::BannedError
    end
  end

  def skip_rate_limiting?
    user_signed_in? && (user_moderator? || user_contributor?)
  end

  class BannedError < StandardError; end

  private

  def user_signed_in?
    user.present?
  end

  def user_signed_out?
    !user_signed_in?
  end

  def user_moderator?
    user.moderators.find { |i| i.sub_id == sub.id }.present?
  end

  def user_contributor?
    user.contributors.find { |i| i.sub_id == sub.id }.present?
  end

  def user_banned?
    user.bans.find { |i| i.sub_id == sub.id }.present?
  end

  def user_follower?
    user.follows.find { |i| i.sub_id == sub.id }.present?
  end
end