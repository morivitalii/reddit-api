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
    user? && user.moderators.any? { |moderator| moderator.community_id == community.id }
  end

  def banned?
    user? && user.bans.any? { |ban| ban.community_id == community.id }
  end
end