class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end

# class ApplicationPolicy
#   class AuthorizationError < StandardError
#   end
#
#   def self.authorize!(action, *args)
#     unless authorize(action, *args)
#       raise AuthorizationError
#     end
#   end
#
#   def self.authorize(action, *args)
#     self.new.method("#{action}?").call(*args)
#   end
#
#   def staff?
#     return false unless user?
#
#     Current.user.cached_staff.present?
#   end
#
#   def master?(sub)
#     return false unless user?
#
#     Current.user.cached_moderators.find { |i| i.master? && i.sub_id == sub.id }.present?
#   end
#
#   def moderator?(sub = nil)
#     return false unless user?
#
#     if sub.present?
#       Current.user.cached_moderators.find { |i| i.sub_id == sub.id }.present?
#     else
#       Current.user.cached_moderators.present?
#     end
#   end
#
#   def contributor?(sub)
#     return false unless user?
#
#     Current.user.cached_contributors.find { |i| i.sub_id == sub.id }.present?
#   end
#
#   def follower?(sub)
#     return false unless user?
#
#     Current.user.cached_follows.find { |i| i.sub_id == sub.id }
#   end
#
#   def banned?(sub)
#     return false unless user?
#
#     ban = Current.user.cached_bans.find { |i| i.sub_id == sub.id }
#
#     return false if ban.blank?
#     return ban if ban.permanent?
#     return ban unless ban.stale?
#
#     DeleteSubBan.new(ban: ban, current_user: User.auto_moderator).call
#
#     false
#   end
#
#   def user?
#     Current.user.present?
#   end
# end