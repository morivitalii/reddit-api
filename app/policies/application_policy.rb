# frozen_string_literal: true

class ApplicationPolicy
  class AuthorizationError < StandardError
  end

  def self.authorize!(action, *args)
    unless authorize(action, *args)
      raise AuthorizationError
    end
  end

  def self.authorize(action, *args)
    self.new.method("#{action}?").call(*args)
  end

  def staff?
    return false unless user?

    Current.user.staff.present?
  end

  def master?(sub)
    return false unless user?

    Current.user.moderators.find { |i| i.master? && i.sub_id == sub.id }.present?
  end

  def moderator?(sub = nil)
    return false unless user?

    if sub.present?
      Current.user.moderators.find { |i| i.sub_id == sub.id }.present?
    else
      Current.user.moderators.present?
    end
  end

  def contributor?(sub)
    return false unless user?

    Current.user.contributors.find { |i| i.sub_id == sub.id }.present?
  end

  def follower?(sub)
    return false unless user?

    Current.user.follows.find { |i| i.sub_id == sub.id }
  end

  def banned?(sub)
    return false unless user?

    ban = Current.user.bans.find { |i| i.sub_id == sub.id }

    return false if ban.blank?
    return ban if ban.permanent?
    return ban unless ban.stale?

    DeleteSubBan.new(ban: ban, current_user: User.auto_moderator).call

    false
  end

  def user?
    Current.user.present?
  end
end
