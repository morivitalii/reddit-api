class ApplicationPolicy
  attr_reader :user, :community, :record

  def initialize(context, record = nil)
    @user = context.user
    @community = context.community
    @record = record
  end

  def skip_rate_limiting?
    moderator?
  end

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
    user? && community.present? && user.bans.any? { |ban| ban.community_id == community.id }
  end
end
