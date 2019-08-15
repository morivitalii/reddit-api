class ApplicationPolicy
  attr_reader :user, :community, :record

  def initialize(context, record)
    @user = context.user
    @community = context.community
    @record = record

    if banned?
      raise ApplicationPolicy::BannedError
    end
  end

  def skip_rate_limiting?
    moderator?
  end

  class BannedError < StandardError; end

  private

  def user?
    user.present?
  end

  def visitor?
    !user?
  end

  def moderator?
    user? && user.moderators.find { |i| i.community_id == community.id }.present?
  end

  def banned?
    user? && user.bans.find { |i| i.community_id == community.id }.present?
  end

  def follower?
    user? && user.follows.find { |i| i.community_id == community.id }.present?
  end
end