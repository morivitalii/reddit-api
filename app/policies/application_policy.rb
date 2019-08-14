class ApplicationPolicy
  attr_reader :user, :community, :record

  def initialize(context, record)
    @user = context.user
    @community = context.community
    @record = record

    if user_signed_in? && user_banned?
      raise ApplicationPolicy::BannedError
    end
  end

  def skip_rate_limiting?
    user_signed_in? && user_moderator?
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
    user.moderators.find { |i| i.community_id == community.id }.present?
  end

  def user_banned?
    user.bans.find { |i| i.community_id == community.id }.present?
  end

  def user_follower?
    user.follows.find { |i| i.community_id == community.id }.present?
  end
end