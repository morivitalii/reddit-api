class ApplicationPolicy
  attr_reader :user, :community, :record

  def initialize(context, record = nil)
    @user = context.user
    @community = context.community
    @record = record
  end

  def skip_rate_limiting?
    admin? || moderator?
  end

  private

  def visitor?
    !user?
  end

  def user?
    user.present?
  end

  def admin?
    user? && user.admin.present?
  end

  def exiled?
    user? && user.exile.present?
  end

  def moderator?
    user? && user.moderators.any? { |moderator| moderator.community_id == community.id }
  end

  def muted?
    user? && community.present? && user.mutes.any? { |mute| mute.source_id == community.id }
  end

  def banned?
    user? && community.present? && user.bans.any? { |ban| ban.source_id == community.id }
  end
end
