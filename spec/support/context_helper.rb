module ContextHelper
  def build_visitor_context
    context = build_context
    context.user = nil

    context
  end

  def build_user_context
    build_context
  end

  def build_follower_context
    context = build_context
    create(:follow, user: context.user, community: context.community)

    context
  end

  def build_moderator_context
    context = build_context
    create(:moderator, user: context.user, community: context.community)

    context
  end

  def build_banned_context
    context = build_context
    create(:ban, user: context.user, community: context.community)

    context
  end

  def build_context
    user = create(:user)
    community = create(:community)

    Context.new(user, community)
  end
end