class ApplicationPolicy
  attr_reader :user, :community, :record

  def initialize(pundit_user, record = nil)
    @user = pundit_user.is_a?(Context) ? pundit_user.user : pundit_user
    @community = pundit_user.is_a?(Context) ? pundit_user.community : nil
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
