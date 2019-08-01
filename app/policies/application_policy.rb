class ApplicationPolicy
  attr_reader :user, :sub, :record

  def initialize(context, record)
    @user = context.user
    @sub = context.sub
    @record = record
  end

  private

  def user_signed_in?
    user.present?
  end

  def user_signed_out?
    !user_signed_in?
  end

  def user_global_moderator?
    user.global_moderator?
  end

  def user_sub_moderator?
    user.sub_moderator?(sub)
  end

  def user_global_contributor?
    user.global_contributor?
  end

  def user_sub_contributor?
    user.sub_contributor?(sub)
  end

  def user_banned_globally?
    user.banned_globally?
  end

  def user_banned_in_sub?
    user.banned_in_sub?(sub)
  end

  def user_sub_follower?
    user.follower?(sub)
  end

  def sub_context?
    sub.present?
  end

  def global_context?
    !sub_context?
  end
end