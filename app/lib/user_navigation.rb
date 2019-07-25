# frozen_string_literal

class UserNavigation
  def initialize(user)
    @user = user
  end

  def moderation
    @moderator_in ||= Sub.joins(:moderators).where(moderators: { user: @user }).all
  end

  def follows
    moderator_in_ids = @moderator_in.map(&:id)
    @follower_in ||= Sub.joins(:follows).where.not(id: moderator_in_ids).where(follows: { user: @user }).all
  end
end