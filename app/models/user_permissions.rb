# frozen_string_literal: true

class UserPermissions
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def moderator?(sub = nil)
    global_moderator? || (sub.present? ? sub_moderator?(sub) : false)
  end

  def contributor?(sub = nil)
    global_contributor? || (sub.present? ? sub_contributor?(sub) : false)
  end

  def banned?(sub = nil)
    banned_globally? || (sub.present? ? banned_in_sub?(sub) : false)
  end

  def follower?(sub)
    user.follows.find { |i| i.sub_id == sub.id }
  end

  private

  def global_moderator?
    user.moderators.find { |i| i.sub_id.blank? }.present?
  end

  def sub_moderator?(sub)
    user.moderators.find { |i| i.sub_id == sub.id }.present?
  end

  def global_contributor?
    user.contributors.find { |i| i.sub_id.blank? }
  end

  def sub_contributor?(sub)
    user.contributors.find { |i| i.sub_id == sub.id }.present?
  end

  def banned_globally?
    ban = user.bans.global.take

    return false if ban.blank?
    return ban if ban.permanent?
    return ban unless ban.stale?

    DeleteBan.new(ban: ban, current_user: User.auto_moderator).call

    false
  end

  def banned_in_sub?(sub)
    ban = user.bans.find { |i| i.sub_id == sub.id }

    return false if ban.blank?
    return ban if ban.permanent?
    return ban unless ban.stale?

    DeleteBan.new(ban: ban, current_user: User.auto_moderator).call

    false
  end
end