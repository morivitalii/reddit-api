class ApplicationPolicy
  attr_reader :user, :sub, :record

  def initialize(context, record)
    @user = context.user
    @sub = context.sub
    @record = record
  end

  def skip_rate_limiting?
    return true if user_global_moderator? || user_global_contributor?

    sub_context? ? (user_sub_moderator? || user_sub_contributor?) : false
  end

  private

  def user_signed_in?
    user.present?
  end

  def user_signed_out?
    !user_signed_in?
  end

  def user_global_moderator?
    moderators.find { |i| i.sub_id.blank? }.present?
  end

  def user_sub_moderator?
    moderators.find { |i| i.sub_id == sub.id }.present?
  end

  def user_global_contributor?
    contributors.find { |i| i.sub_id.blank? }.present?
  end

  def user_sub_contributor?
    contributors.find { |i| i.sub_id == sub.id }.present?
  end

  def user_banned_globally?
    bans.find { |i| i.sub_id.blank? }.present?
  end

  def user_banned_in_sub?
    bans.find { |i| i.sub_id == sub.id }.present?
  end

  def user_sub_follower?
    follows.find { |i| i.sub_id == sub.id }.present?
  end

  def sub_context?
    sub.present?
  end

  def global_context?
    !sub_context?
  end

  def moderators
    @_moderators ||= user.moderators
  end

  def contributors
    @_contributors ||= user.contributors
  end

  def bans
    @_bans ||= user.bans
  end

  def follows
    @_follows ||= user.follows
  end
end