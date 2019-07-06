class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def staff?
    return false unless user?

    user.staff.present?
  end

  def master?(sub)
    return false unless user?

    user.moderators.find { |i| i.master? && i.sub_id == sub.id }.present?
  end

  def moderator?(sub = nil)
    return false unless user?

    if sub.present?
      user.moderators.find { |i| i.sub_id == sub.id }.present?
    else
      user.moderators.present?
    end
  end

  def contributor?(sub)
    return false unless user?

    user.contributors.find { |i| i.sub_id == sub.id }.present?
  end

  def follower?(sub)
    return false unless user?

    user.follows.find { |i| i.sub_id == sub.id }
  end

  def banned?(sub)
    return false unless user?

    ban = user.bans.find { |i| i.sub_id == sub.id }

    return false if ban.blank?
    return ban if ban.permanent?
    return ban unless ban.stale?

    DeleteSubBan.new(ban: ban, current_user: User.auto_moderator).call

    false
  end

  def user?
    user.present?
  end
end