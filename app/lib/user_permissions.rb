# frozen_string_literal: true

class UserPermissions
  attr_reader :user

  def initialize(user)
    @user = user
  end

  # TODO remove
  def moderator?(sub = nil)
    global_moderator? || (sub.present? ? sub_moderator?(sub) : false)
  end

  def global_moderator?
    moderators.find { |i| i.sub_id.blank? }.present?
  end

  def sub_moderator?(sub)
    moderators.find { |i| i.sub_id == sub.id }.present?
  end

  # TODO remove
  def contributor?(sub = nil)
    global_contributor? || (sub.present? ? sub_contributor?(sub) : false)
  end

  def global_contributor?
    contributors.find { |i| i.sub_id.blank? }.present?
  end

  def sub_contributor?(sub)
    contributors.find { |i| i.sub_id == sub.id }.present?
  end

  # TODO remove
  def banned?(sub = nil)
    banned_globally? || (sub.present? ? banned_in_sub?(sub) : false)
  end

  def banned_globally?
    bans.find { |i| i.sub_id.blank? }.present?
  end

  def banned_in_sub?(sub)
    bans.find { |i| i.sub_id == sub.id }.present?
  end

  # TODO rename to sub_follower?
  def follower?(sub)
    follows.find { |i| i.sub_id == sub.id }.present?
  end

  private

  def moderators
    @moderators ||= user.moderators
  end

  def contributors
    @contributors ||= user.contributors
  end

  def bans
    @bans ||= user.bans
  end

  def follows
    @follows ||= user.follows
  end
end