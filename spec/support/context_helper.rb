module ContextHelper
  def build_visitor_context
    community = create(:community)

    build_context(nil, community)
  end

  def build_user_context
    user = create(:user)
    community = create(:community)

    build_context(user, community)
  end

  alias build_default_context build_user_context

  def build_follower_context
    user = create(:user)
    community = create(:community_with_user_follower, user: user)

    build_context(user, community)
  end

  def build_moderator_context
    user = create(:user)
    community = create(:community_with_user_moderator, user: user)

    build_context(user, community)
  end

  def build_banned_context
    user = create(:user)
    community = create(:community_with_banned_user, user: user)

    build_context(user, community)
  end

  def build_context(user, community)
    Context.new(user, community)
  end
end